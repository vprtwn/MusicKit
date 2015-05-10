//
//  MIDI.swift
//  MIDI
//
//  Created by Ben Guo on 5/9/15.
//  Copyright (c) 2015 Net Sadness. All rights reserved.
//

import Foundation
import CoreMIDI

public class MIDI {
    var sources : [MIDIEndpointRef] = []
    var destinations : [MIDIEndpointRef] = []
    lazy var client : MIDIClientRef = {
        var _client = MIDIClientRef()
        let s = MIDIClientCreate("MusicKit",
            MIDIProc.notifyProc(),
            nil,
            &_client)
        MIDIProc.setNotifyProc({ (notification) -> Void in
            print(notification)
        })
        return _client
    }()

    lazy var inputPort : MIDIPortRef = {
        var _inputPort = MIDIPortRef()
        let s = MIDIInputPortCreate(self.client,
            "MusicKit",
            MIDIProc.readProc(),
            nil,
            &_inputPort);
        MIDIProc.setReadProc({ (packetList) -> Void in
            print(packetList)
        })
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
