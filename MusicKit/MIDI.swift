//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation
import CoreMIDI

public class MIDI {
    var sources : [MIDIEndpointRef] = []
    var destinations : [MIDIEndpointRef] = []

    lazy var client : MIDIClientRef = {
        var _client = MIDIClientRef()
        let s = MIDIClientCreate("MusicKit",
            MKMIDIProc.notifyProc(),
            nil,
            &_client)
        MKMIDIProc.setNotifyCallback { messageId in
            if messageId == MKMIDINotification.SetupChanged {
                self.scanSources()
                self.scanDestinations()
            }
        }
        return _client
    }()

    lazy var inputPort : MIDIPortRef = {
        var _inputPort = MIDIPortRef()
        let s = MIDIInputPortCreate(self.client,
            "MusicKit",
            MKMIDIProc.readProc(),
            nil,
            &_inputPort);
        MKMIDIProc.setReadCallback { packetList in
            var messages = [MIDIMessage]()
            for packet in packetList {
                let channel = packet[0] as! UInt
                let message = packet[1] as! UInt
                let noteOn = UInt(MKMIDIMessage.NoteOn.rawValue)
                let noteOff = UInt(MKMIDIMessage.NoteOff.rawValue)
                let noteMessages = [noteOn, noteOff]
                if contains(noteMessages, message) {
                    let noteNumber = packet[2] as! UInt
                    let velocity = packet[3] as! UInt
                    let m = MIDINoteMessage(on: message == noteOn || velocity == 0,
                        channel: UInt(channel),
                        noteNumber: UInt(noteNumber),
                        velocity: UInt(velocity))
                    messages.append(m)
                    self.updateInputChannelToPitchSet(m)
                }
            }
            self.messageHandler(messages)
        }
        return _inputPort
    }()

    /// Handler for incoming MIDI messages
    public var messageHandler : [MIDIMessage] -> Void = { messages in }

    /// The current pitch set in each input channel
    public var inputChannelToPitchSet = [UInt: PitchSet]()

    func updateInputChannelToPitchSet(message: MIDINoteMessage) {
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

    public init() {
        scanSources()
        scanDestinations()
    }

    public func scanSources() {
        let sourceCount = MIDIGetNumberOfSources()
        // disconnect from current sources
        for source in sources {
            MIDIPortDisconnectSource(inputPort, source)
        }
        var newSources = [MIDIEndpointRef]()
        for i in 0..<sourceCount {
            let endpointRef = MIDIGetSource(i)
            let s = MIDIPortConnectSource(inputPort, endpointRef, nil)
            newSources.append(endpointRef)
        }
        sources = newSources
    }

    public func scanDestinations() {
        let destinationCount = MIDIGetNumberOfDestinations()
        var newDestinations = [MIDIEndpointRef]()
        for i in 0..<destinationCount {
            let endpointRef = MIDIGetDestination(i)
            newDestinations.append(endpointRef)
        }
        destinations = newDestinations
    }
}
