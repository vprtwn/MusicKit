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

    override func viewDidLoad() {
        super.viewDidLoad()
        let midi = MIDI()
        midi.messageHandler = { messages in
            print("\(messages)\n")
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

