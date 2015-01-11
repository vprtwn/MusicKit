//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// a ChordTuple describes a chord with an array of intervals, a full name, and an abbreviated name
public typealias ChordTuple = ([Float], String, String)

public enum ChordAddition : Float {
    case FlatNine = 13
    case Nine = 14
    case Eleven = 17
    case SharpEleven = 18
    case FlatThirteen = 20
    case Thirteen = 21
}

public enum Chord  {
    public static func invert(semitones: [Float], n: UInt) -> [Float] {
        let count = semitones.count
        let modN = Int(n) % count
        var semitones = semitones
        for i in 0..<modN {
            let next = semitones[0] + 12
            semitones = Array(semitones[1..<count] + [next])
        }
        return semitones
    }

    /// Converts an array of semitones to intervals
    /// e.g. [0, 4, 7] -> [4, 3]
    static func semitones(intervals: [Float]) -> [Float] {
        var semitones : [Float] = [0]
        for i in 0..<intervals.count {
            let next = semitones[i] + intervals[i]
            semitones.append(next)
        }
        return semitones
    }

    /// Converts an array of intervals to semitones
    /// e.g. [4, 3] -> [0, 4, 7]
    static func intervals(semitones: [Float]) -> [Float] {
        return []
    }

    public static func create(scale: (Pitch -> PitchSet), indices: [UInt]) -> (Pitch -> PitchSet) {
        return { pitch in
            PitchSet()
        }
    }

    public static func create(intervals: [Float]) -> (Pitch -> PitchSet) {
        return { firstPitch in
            var pitchSet = PitchSet()
            pitchSet.add(firstPitch)
            var previousPitch = firstPitch
            let chordLength = intervals.count + 1
            var midiNum = firstPitch.midiNumber
            for i in 1..<chordLength {
                let prevDegree = (i-1)
                let interval = intervals[prevDegree]
                midiNum = midiNum + interval
                var pitch = Pitch(midiNumber: midiNum)

                if let pitchClass = pitch.pitchClass {
                    if let previousPitchName = previousPitch.noteNameTuple {
                        var preferredLetterName : LetterName?
                        // maj/min second
                        if interval == 1 || interval == 2 {
                            preferredLetterName = previousPitchName.0.next()
                        }
                        // maj/min third
                        else if interval == 3 || interval == 4 {
                            preferredLetterName = previousPitchName.0.next().next()
                        }
                        let preferredPitchName = pitchClass.names.filter {
                            n in n.0 == preferredLetterName
                            }.first
                        pitch.preferredName = preferredPitchName
                    }
                }

                pitchSet.add(pitch)
                previousPitch = pitch
            }
            return pitchSet
        }
    }

    static let _Major : ChordTuple = ([4, 3], "Major triad", "")
    static let _Minor : ChordTuple = ([3, 4], "Minor triad", "m")
    static let _Augmented : ChordTuple = ([4, 4], "Augmented triad", "+")
    static let _Diminished : ChordTuple = ([3, 3], "Diminished triad", "°")
    // TODO: add Sus2, Sus4

    static let _DominantSeventh : ChordTuple = ([4, 3, 3], "Dominant seventh", "7")
    static let _MajorSeventh : ChordTuple = ([4, 3, 4], "Major seventh", "Δ7")
    static let _MinorMajorSeventh : ChordTuple = ([3, 4, 4], "Minor-major seventh", "mΔ7")
    static let _MinorSeventh : ChordTuple = ([3, 4, 3], "Minor seventh", "m7")
    static let _AugmentedMajorSeventh : ChordTuple = ([4, 4, 3], "Augmented-major seventh", "+Δ7")
    static let _AugmentedSeventh : ChordTuple = ([4, 4, 2], "Augmented seventh", "+7")
    static let _HalfDiminishedSeventh : ChordTuple = ([3, 3, 4], "Half-diminished seventh", "ø7")
    static let _DiminishedSeventh : ChordTuple = ([3, 3, 3], "Diminished seventh", "°")
    static let _DominantSeventhFlatFive : ChordTuple = ([4, 2, 4], "Dominant seventh flat five", "7♭5")
    // TODO: add M6, m6

    public static func Major(inversion: UInt = 0, additions: [ChordAddition] = []) -> (Pitch -> PitchSet) {
        // convert to semitones
        // add additions
        // invert
        // convert to intervals
        return create(_Major.0)
    }

}
