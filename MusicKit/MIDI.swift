//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation
import CoreMIDI

open class MIDI {
    /// Messages sent to the virtual MIDI source will be delivered on this channel.
    /// Default is 3.
    open var sourceChannel: UInt = 3

    /// Handler for incoming MIDI note on or off messages
    open var noteHandler: ([MIDINoteMessage]) -> Void = { messages in }

    /// The current pitch set in each input channel
    open var inputChannelToPitchSet = [UInt: PitchSet]()

    /// The current pitch set in the source channel
    open var sourcePitchSet: PitchSet {
        return self.inputChannelToPitchSet[sourceChannel] ?? PitchSet()
    }

    var _sources: [MIDIEndpointRef] = []
    var _destinations: [MIDIEndpointRef] = []
    var _name = "MusicKit"

    /// The virtual source
    lazy var _virtualSource: MIDIEndpointRef = {
        var outSrc = MIDIEndpointRef()
        let s = MIDISourceCreate(self._client, self._name as CFString, &outSrc)
        return outSrc
    }()

    /// The MIDI client
    lazy var _client: MIDIClientRef = {
        var outClient = MIDIClientRef()
        let s = MIDIClientCreate(self._name as CFString, MKMIDIProc.notify(), nil, &outClient)

        return outClient
    }()

    /// The MIDI input port
    lazy var _inputPort: MIDIPortRef = {
        var outPort = MIDIPortRef()
        let s = MIDIInputPortCreate(self._client, self._name as CFString, MKMIDIProc.read(), nil, &outPort)
        return outPort
    }()

    /// Sends messages to the virtual MIDI source.
    ///
    /// Note that messages are always sent on `sourceChannel`.
    ///
    /// :returns: `true` if the message was successfully sent
    open func send<T: MIDIMessage>(_ messages: [T]) -> Bool {
        var success = false
        var packet = UnsafeMutablePointer<MIDIPacket>.allocate(capacity: MemoryLayout<MIDIPacket>.size)
        let packetList = UnsafeMutablePointer<MIDIPacketList>.allocate(capacity: MemoryLayout<MIDIPacketList>.size)
        packet = MIDIPacketListInit(packetList)

        for message in messages {
            let data = message.copyOnChannel(sourceChannel).data()
            packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, data)
        }
        let s = MIDIReceived(_virtualSource, packetList)
        success = s == 0

        packet.deinitialize()
        // this dealloc is superfluous; not sure why.
//        packet.dealloc(sizeof(MIDIPacket))
        packetList.deinitialize()
        packetList.deallocate(capacity: MemoryLayout<MIDIPacketList>.size)
        return success
    }

    func _updateInputChannelToPitchSet(_ message: MIDINoteMessage) {
        let pitch = Pitch(midi: Float(message.noteNumber))
        if let pitchSet = inputChannelToPitchSet[message.channel] {
            var pitchSet = pitchSet
            if message.on {
                pitchSet.insert(pitch)
            }
            else {
                _ = pitchSet.remove(pitch)
            }
            inputChannelToPitchSet[message.channel] = pitchSet
        }
        else if message.on {
            inputChannelToPitchSet[message.channel] = PitchSet(pitches: pitch)
        }
    }

    public init(name: String) {
        self._name = name
        _scanSources()
        _scanDestinations()
        MKMIDIProc.setNotifyCallback { messageId in
            if messageId == MKMIDINotification.setupChanged {
                self._scanSources()
                self._scanDestinations()
            }
        }
        MKMIDIProc.setReadCallback { packetList in
            var noteMessages = [MIDINoteMessage]()
            for packet in packetList! {
                let packet = packet as! Array<UInt>
                let channel = packet[0]
                let messageType = packet[1]
                let noteOn = UInt(MKMIDIMessage.noteOn.rawValue)
                let noteOff = UInt(MKMIDIMessage.noteOff.rawValue)
                let noteMessageTypes = [noteOn, noteOff]
                if noteMessageTypes.contains(messageType) {
                    let noteNumber = packet[2]
                    let velocity = packet[3]
                    let m = MIDINoteMessage(on: messageType == noteOn || velocity == 0,
                        channel: UInt(channel),
                        noteNumber: UInt(noteNumber),
                        velocity: UInt(velocity))
                    // filter messages from our virtual source
                    if channel != self.sourceChannel {
                        noteMessages.append(m)
                    }
                    self._updateInputChannelToPitchSet(m)
                }
            }
            if noteMessages.count > 0 {
                self.noteHandler(noteMessages)
            }
        }
    }

    /// Scans and connects to MIDI sources
    func _scanSources() {
        let sourceCount = MIDIGetNumberOfSources()
        // disconnect from current sources
        for source in _sources {
            MIDIPortDisconnectSource(_inputPort, source)
        }
        var newSources = [MIDIEndpointRef]()
        for i in 0..<sourceCount {
            let endpointRef = MIDIGetSource(i)
            let _ = MIDIPortConnectSource(_inputPort, endpointRef, nil)
            newSources.append(endpointRef)
        }
        _sources = newSources
    }

    /// Scans for MIDI destinations
    func _scanDestinations() {
        let destinationCount = MIDIGetNumberOfDestinations()
        var newDestinations = [MIDIEndpointRef]()
        for i in 0..<destinationCount {
            let endpointRef = MIDIGetDestination(i)
            newDestinations.append(endpointRef)
        }
        _destinations = newDestinations
    }
}
