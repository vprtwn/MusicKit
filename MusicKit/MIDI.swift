//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation
import CoreMIDI

public class MIDI {
    /// Messages sent to the virtual MIDI source will be delivered on this channel.
    /// Default is 3.
    public var sourceChannel: UInt = 3

    /// Handler for incoming MIDI note on or off messages
    public var noteHandler: [MIDINoteMessage] -> Void = { messages in }

    /// The current pitch set in each input channel
    public var inputChannelToPitchSet = [UInt: PitchSet]()

    /// The current pitch set in the source channel
    public var sourcePitchSet: PitchSet {
        return self.inputChannelToPitchSet[sourceChannel] ?? PitchSet()
    }

    var _sources: [MIDIEndpointRef] = []
    var _destinations: [MIDIEndpointRef] = []
    var _name = "MusicKit"

    /// The virtual source
    lazy var _virtualSource: MIDIEndpointRef = {
        var outSrc = MIDIEndpointRef()
        let s = MIDISourceCreate(self._client, self._name, &outSrc)
        return outSrc
    }()

    /// The MIDI client
    lazy var _client: MIDIClientRef = {
        var outClient = MIDIClientRef()
        let s = MIDIClientCreate(self._name, MKMIDIProc.notifyProc(), nil, &outClient)

        return outClient
    }()

    /// The MIDI input port
    lazy var _inputPort: MIDIPortRef = {
        var outPort = MIDIPortRef()
        let s = MIDIInputPortCreate(self._client, self._name, MKMIDIProc.readProc(), nil, &outPort)
        return outPort
    }()

    /// Sends messages to the virtual MIDI source.
    ///
    /// Note that messages are always sent on `sourceChannel`.
    ///
    /// :returns: `true` if the message was successfully sent
    public func send<T: MIDIMessage>(messages: [T]) -> Bool {
        var success = false
        var packet = UnsafeMutablePointer<MIDIPacket>.alloc(sizeof(MIDIPacket))
        let packetList = UnsafeMutablePointer<MIDIPacketList>.alloc(sizeof(MIDIPacketList))
        packet = MIDIPacketListInit(packetList)

        for message in messages {
            let data = message.copyOnChannel(sourceChannel).data()
            packet = MIDIPacketListAdd(packetList, 1024, packet, 0, 3, data)
        }
        if packet != nil {
            let s = MIDIReceived(_virtualSource, packetList)
            success = s == 0
        } else {
            success = false
        }
        packet.destroy()
        // this dealloc is superfluous; not sure why.
//        packet.dealloc(sizeof(MIDIPacket))
        packetList.destroy()
        packetList.dealloc(sizeof(MIDIPacketList))
        return success
    }

    func _updateInputChannelToPitchSet(message: MIDINoteMessage) {
        let pitch = Pitch(midi: Float(message.noteNumber))
        if let pitchSet = inputChannelToPitchSet[message.channel] {
            var pitchSet = pitchSet
            if message.on {
                pitchSet.insert(pitch)
            }
            else {
                pitchSet.remove(pitch)
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
            if messageId == MKMIDINotification.SetupChanged {
                self._scanSources()
                self._scanDestinations()
            }
        }
        MKMIDIProc.setReadCallback { packetList in
            var noteMessages = [MIDINoteMessage]()
            for packet in packetList {
                let channel = packet[0] as! UInt
                let messageType = packet[1] as! UInt
                let noteOn = UInt(MKMIDIMessage.NoteOn.rawValue)
                let noteOff = UInt(MKMIDIMessage.NoteOff.rawValue)
                let noteMessageTypes = [noteOn, noteOff]
                if noteMessageTypes.contains(messageType) {
                    let noteNumber = packet[2] as! UInt
                    let velocity = packet[3] as! UInt
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
