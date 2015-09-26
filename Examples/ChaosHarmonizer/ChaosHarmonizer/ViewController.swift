//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Cocoa
import MusicKit

class ViewController: NSViewController {

    var noteNumberToPitchSet = [UInt : PitchSet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let midi = MIDI(name: "ChaosHarmonizer")
        midi.noteHandler = { messages in
            if let first = messages.first {
                if first.on {
                    let possibleChords = [
                        ChordQuality.Major,
                        ChordQuality.Minor,
                        ChordQuality.Sus2,
                        ChordQuality.Sus4,
                    ]
//                    + ChordQuality.Pentads
                    let index = arc4random_uniform(UInt32(possibleChords.count))
                    let quality = possibleChords[Int(index)]
                    let intervals = quality.intervals
                    let indices = MKUtil.semitoneIndices(intervals)
                    let transposition = indices[indices.count - 1]*(-1)
                    let harmonizer = Harmony.transpose(Harmony.create(intervals), semitones: transposition)
                    let pitch = Pitch(midi: Float(first.noteNumber))
                    let pitchSet = harmonizer(pitch)
                    self.noteNumberToPitchSet[first.noteNumber] = pitchSet
                    var messages = first.harmonize(harmonizer)
                    messages.append(first)
                    midi.send(messages)
                }
                else {
                    var offMessages = [MIDINoteMessage]()
                    if let pitchSet = self.noteNumberToPitchSet[first.noteNumber] {
                        for pitch in pitchSet {
                            let message = MIDINoteMessage(on: false,
                                channel: first.channel,
                                noteNumber: UInt(pitch.midi), velocity: 0)
                            offMessages.append(message)
                            offMessages.append(first)
                        }
                        midi.send(offMessages)
                    }
                }
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }


}

