//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Ordered set of Pitches
public struct PitchSet : CollectionType, Printable {

    var pitches : [Pitch] = []
    public var startIndex : Int = 0
    public var endIndex : Int = 0

    public init() {

    }

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

    public static func transpose(f: Pitch -> PitchSet, semitones: Float) -> (Pitch -> PitchSet) {
        return { pitch in
            f(Pitch(midiNumber: pitch.midiNumber + semitones))
        }
    }
}


