//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Ordered set of Pitches
public struct PitchSet : CollectionType, Printable {

    var pitches : [Pitch] = []
    public var startIndex : Int = 0
    public var endIndex : Int = 0

    public init() {

    }

    public init(intervals: [Float], firstPitch: Pitch, count: Int) {
        self.endIndex = count - 1

        pitches.append(firstPitch)
        var previousPitch = firstPitch
        var chordLength = 5
        var midiNum = firstPitch.midiNumber
        for i in 1..<count {
            let firstInterval = intervals[(i-1) % chordLength]
            let secondInterval = intervals[i % chordLength]
            var delta : Float = 0.0

            if secondInterval >= firstInterval {
                delta = secondInterval - firstInterval
            }
            else {
                delta = secondInterval + 12 - firstInterval
            }
            midiNum += delta
            var pitch = Pitch(midiNumber: midiNum)

            // set a preferred pitch class name
            if i < chordLength {
                if let pitchClass = pitch.pitchClass {
                    if let previousPitchName = previousPitch.noteNameTuple {
                        var preferredLetterName : LetterName?
                        // maj/min second
                        if delta == 1 || delta == 2 {
                            preferredLetterName = previousPitchName.0.next()
                        }
                        // maj/min third
                        else if delta == 3 || delta == 4 {
                            preferredLetterName = previousPitchName.0.next().next()
                        }
                        let preferredPitchName = pitchClass.names.filter {
                            n in n.0 == preferredLetterName
                            }.first
                        pitch.preferredName = preferredPitchName
                    }
                }
            }
            else {
                let pitchOctaveBelow = pitches[i - chordLength]
                pitch.preferredName = pitchOctaveBelow.preferredName
            }

            pitches.append(pitch)
            previousPitch = pitch
        }
    }

    // MARK: CollectionType

    public func generate() -> GeneratorOf<Pitch> {
        var index = startIndex
        return GeneratorOf<Pitch> {
            if index <= self.endIndex {
                let pitch = self.pitches[index]
                index++
                return pitch
            }
            else {
                return nil
            }
        }
    }

    // O(n) :(
    public mutating func add(pitch: Pitch) {
        let count = pitches.count
        if count == 0 {
            pitches.append(pitch)
            endIndex++
        }
        else if count == 1 {
            if pitch < pitches[0] {
                pitches.insert(pitch, atIndex: 0)
                endIndex++
            }
            else if pitch > pitches[0] {
                pitches.append(pitch)
                endIndex++
            }
        }
        else {
            if pitch < pitches.first {
                pitches.insert(pitch, atIndex: 0)
                endIndex++
            }
            for i in 1..<pitches.count {
                let previousPitch = pitches[i-1]
                let currentPitch = pitches[i]
                if pitch > previousPitch && pitch < currentPitch {
                    pitches.insert(pitch, atIndex: i)
                    endIndex++
                }
            }
            let lastPitchOpt = pitches.last
            if let lastPitch = lastPitchOpt {
                if pitch > lastPitch {
                    pitches.append(pitch)
                    endIndex++
                }
            }
        }
    }

    public subscript(i: Int) -> Pitch {
        return pitches[i]
    }

    public var description : String {
        return pitches.description
    }
}


