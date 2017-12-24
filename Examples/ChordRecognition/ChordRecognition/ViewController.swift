//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Cocoa
import MusicKit

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let midi = MIDI(name: "Chord Recognition")
        midi.noteHandler = { _ in
            self.textField.stringValue = midi.inputChannelToPitchSet.keys.sort().map {
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
        }
    }


}

