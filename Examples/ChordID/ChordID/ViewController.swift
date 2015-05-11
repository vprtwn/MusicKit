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
        midi.messageHandler = { _ in
            self.textField.stringValue = sorted(midi.inputChannelToPitchSet.keys).map {
                Chord.name(midi.inputChannelToPitchSet[$0] ?? PitchSet())
            }.reduce("", combine: { (a, r) -> String in
                return a + "\n\(r ?? String())"
            })
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

