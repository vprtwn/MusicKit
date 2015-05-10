//
//  ViewController.swift
//  ChordID
//
//  Created by Ben Guo on 5/10/15.
//  Copyright (c) 2015 Ben Guo. All rights reserved.
//

import Cocoa
import MusicKit

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let midi = MIDI()
        midi.messageHandler = { messages in
            var text = ""
            for key in midi.inputChannelToPitchSet.keys {
                let pitchSet = midi.inputChannelToPitchSet[key] ?? PitchSet()
                Chord.name(pitchSet).map { text = text + "\($0)\n" }
            }
            self.textField.stringValue = text
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

