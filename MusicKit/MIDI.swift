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
        MKMIDIProc.setNotifyCallback { notification in
            print(notification)
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
                let channel = packet[0] as! UInt8
                let message = packet[1] as! UInt8
                let noteOn = MKMIDIMessage.NoteOn.rawValue
                let noteOff = MKMIDIMessage.NoteOff.rawValue
                let noteMessages = [noteOn, noteOff]
                if contains(noteMessages, message) {
                    let noteNumber = packet[2] as! UInt8
                    let velocity = packet[3] as! UInt8
                    let m = MIDINoteMessage(on: message == noteOn,
                        channel: UInt(channel),
                        noteNumber: UInt(velocity),
                        velocity: UInt(velocity))
                    messages.append(m)
                }
            }
            print(packetList)
        }
        return _inputPort
    }()

    public init() {

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
