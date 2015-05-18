//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Cocoa
import MusicKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let midi = MIDI(name: "ChaosHarmonizer")
        midi.noteHandler = { messages in
            if let first = messages.first {
                let possibleChords = ChordQuality.Hexads
                let index = arc4random_uniform(UInt32(possibleChords.count))
                let quality = possibleChords[Int(index)]
                let intervals = quality.intervals
                let indices = MKUtil.semitoneIndices(intervals)
                let semitones = indices[indices.count - 1]
                let harmonizer = Harmony.transpose(Harmony.create(intervals), semitones: semitones)
                midi.send([first, first.transpose(2), first.transpose(3)])
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }


}

