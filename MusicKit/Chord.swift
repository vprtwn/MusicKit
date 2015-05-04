//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// (intervals, full name, abbreviated name)
public typealias ChordTuple = ([Float], String, String)

public enum ChordAddition : Float {
    case FlatNine = 13
    case Nine = 14
    case Eleven = 17
    case SharpEleven = 18
    case FlatThirteen = 20
    case Thirteen = 21
}

/// Phantom type containing functions for creating chord Harmonizers
public enum Chord  {
    /// Inverts an array of indices
    // TODO: move this to utilities
    static func invert(indices: [Float], n: UInt) -> [Float] {
        let count = indices.count
        let modN = Int(n) % count
        var semitones = indices
        for i in 0..<modN {
            let next = semitones[0] + 12
            semitones = Array(semitones[1..<count] + [next])
        }
        return semitones
    }

    /// Converts an array of indices to intervals
    /// e.g. [0, 4, 7] -> [4, 3]
    // TODO: move this to utilities
    static func indices(intervals: [Float]) -> [Float] {
        var indices : [Float] = [0]
        for i in 0..<intervals.count {
            let next = indices[i] + intervals[i]
            indices.append(next)
        }
        return indices
    }

    /// Converts an array of intervals to indices
    /// e.g. [4, 3] -> [0, 4, 7]
    // TODO: move this to utilities
    static func intervals(indices: [Float]) -> [Float] {
        var intervals : [Float] = []
        for i in 1..<indices.count {
            let delta = indices[i] - indices[i-1]
            intervals.append(delta)
        }
        return intervals
    }

    /// Transposes a Harmonizer
    // TODO: move this to a protocol
    static func transpose(f: Harmonizer, semitones: Float) -> Harmonizer {
        return { pitch in
            f(Pitch(midi: pitch.midi + semitones))
        }
    }

    public static func create(harmonizer: Harmonizer, indices: [UInt]) -> Harmonizer {
        if indices.count < 2 {
            return Harmony.IdentityHarmonizer
        }

        // sort indices
        var indices = indices
        indices.sort { $0 < $1 }
        let maxIndex : Int = Int(indices.last!)

        // create a scale extending enough octaves to include the max index
        var scalePitchSet = PitchSet()
        var firstPitch = Pitch(midi: 69)
        while (scalePitchSet.count < maxIndex) {
            let scaleOctave = harmonizer(firstPitch)
            scalePitchSet += scaleOctave
            firstPitch = Pitch(midi: firstPitch.midi + 12)
        }

        var intervals : [Float] = []
        for i in 1..<indices.count {
            let prevIndex = Int(indices[i-1])
            let curIndex = Int(indices[i])
            let prevPitch = scalePitchSet[prevIndex]
            let curPitch = scalePitchSet[curIndex]
            let delta = curPitch.midi - prevPitch.midi
            intervals.append(delta)
        }

        return create(intervals)
    }

    public static func create(intervals: [Float]) -> Harmonizer {
        return { firstPitch in
            var pitchSet = PitchSet()
            pitchSet.insert(firstPitch)
            var previousPitch = firstPitch
            let chordLength = intervals.count + 1
            var midiNum = firstPitch.midi
            for i in 1..<chordLength {
                let prevDegree = (i-1)
                let interval = intervals[prevDegree]
                midiNum = midiNum + interval
                var pitch = Pitch(midi: midiNum)

                if let chroma = pitch.chroma {
                    if let previousPitchName = previousPitch.noteNameTuple {
                        var preferredLetterName : LetterName?
                        // maj/min second
                        if interval == 1 || interval == 2 {
                            preferredLetterName = previousPitchName.0 + 1
                        }
                        // maj/min third
                        else if interval == 3 || interval == 4 {
                            preferredLetterName = previousPitchName.0 + 2
                        }
                        let preferredPitchName = chroma.names.filter {
                            n in n.0 == preferredLetterName
                            }.first
                        pitch.preferredName = preferredPitchName
                    }
                }

                pitchSet.insert(pitch)
                previousPitch = pitch
            }
            return pitchSet
        }
    }

    static func create(intervals: [Float], inversion: UInt, additions: [ChordAddition]) -> Harmonizer {
        // convert to indices
        let originalIndices = Chord.indices(intervals)
        var indices = originalIndices

        // add additions
        for addition in additions {
            indices.append(addition.rawValue)
        }

        // invert
        let inversion = Int(inversion) % indices.count
        indices = invert(indices, n: UInt(inversion))

        // convert to intervals
        let intervals = Chord.intervals(indices)

        return Chord.transpose(create(intervals), semitones: originalIndices[inversion])
    }

    static let _Major : ChordTuple = ([4, 3], "Major triad", "")
    static let _Minor : ChordTuple = ([3, 4], "Minor triad", "m")
    static let _Augmented : ChordTuple = ([4, 4], "Augmented triad", "+")
    static let _Diminished : ChordTuple = ([3, 3], "Diminished triad", "°")
    static let _Sus2 : ChordTuple = ([2, 5], "Suspended second", "sus2")
    static let _Sus4 : ChordTuple = ([5, 2], "Suspended fourth", "sus4")

    static let _DominantSeventh : ChordTuple = ([4, 3, 3], "Dominant seventh", "7")
    static let _MajorSeventh : ChordTuple = ([4, 3, 4], "Major seventh", "Δ7")
    static let _MinorMajorSeventh : ChordTuple = ([3, 4, 4], "Minor-major seventh", "mΔ7")
    static let _MinorSeventh : ChordTuple = ([3, 4, 3], "Minor seventh", "m7")
    static let _AugmentedMajorSeventh : ChordTuple = ([4, 4, 3], "Augmented-major seventh", "+Δ7")
    static let _AugmentedSeventh : ChordTuple = ([4, 4, 2], "Augmented seventh", "+7")
    static let _HalfDiminishedSeventh : ChordTuple = ([3, 3, 4], "Half-diminished seventh", "ø7")
    static let _DiminishedSeventh : ChordTuple = ([3, 3, 3], "Diminished seventh", "°")
    static let _DominantSeventhFlatFive : ChordTuple = ([4, 2, 4], "Dominant seventh flat five", "7♭5")
    static let _MajorSeventhFlatFive : ChordTuple = ([5, 2, 4], "Major seventh flat five", "Δ7♭5")
    static let _DominantSeventhSusFour : ChordTuple = ([5, 2, 3], "Dominant seventh sus four", "7sus4")
    static let _MajorSeventhSusFour : ChordTuple = ([5, 2, 4], "Major seventh sus four", "Δ7sus4")
    static let _MajorSixth : ChordTuple = ([4, 3, 2], "Major sixth", "6")
    static let _MinorSixth : ChordTuple = ([3, 4, 2], "Minor sixth", "m6")

    /// TODO: autogenerate the code below using the above tuples
    public static let Major : Harmonizer = Chord.Major(inversion: 0, additions: [])
    public static func Major(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Major.0, inversion: inversion, additions: additions)
    }
    public static let Minor : Harmonizer = Chord.Minor(inversion: 0, additions: [])
    public static func Minor(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Minor.0, inversion: inversion, additions: additions)
    }
    public static let Augmented : Harmonizer = Chord.Augmented(inversion: 0, additions: [])
    public static func Augmented(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Augmented.0, inversion: inversion, additions: additions)
    }
    public static let Diminished : Harmonizer = Chord.Diminished(inversion: 0, additions: [])
    public static func Diminished(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Diminished.0, inversion: inversion, additions: additions)
    }
    public static let Sus2 : Harmonizer = Chord.Sus2(inversion: 0, additions: [])
    public static func Sus2(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Sus2.0, inversion: inversion, additions: additions)
    }
    public static let Sus4 : Harmonizer = Chord.Sus4(inversion: 0, additions: [])
    public static func Sus4(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_Sus4.0, inversion: inversion, additions: additions)
    }
    public static let DominantSeventh : Harmonizer = Chord.DominantSeventh(inversion: 0, additions: [])
    public static func DominantSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_DominantSeventh.0, inversion: inversion, additions: additions)
    }
    public static let MajorSeventh : Harmonizer = Chord.MajorSeventh(inversion: 0, additions: [])
    public static func MajorSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MajorSeventh.0, inversion: inversion, additions: additions)
    }
    public static let MinorMajorSeventh : Harmonizer = Chord.MinorMajorSeventh(inversion: 0, additions: [])
    public static func MinorMajorSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MinorMajorSeventh.0, inversion: inversion, additions: additions)
    }
    public static let MinorSeventh : Harmonizer = Chord.MinorSeventh(inversion: 0, additions: [])
    public static func MinorSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MinorSeventh.0, inversion: inversion, additions: additions)
    }
    public static let AugmentedMajorSeventh : Harmonizer = Chord.AugmentedMajorSeventh(inversion: 0, additions: [])
    public static func AugmentedMajorSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_AugmentedMajorSeventh.0, inversion: inversion, additions: additions)
    }
    public static let AugmentedSeventh : Harmonizer = Chord.AugmentedSeventh(inversion: 0, additions: [])
    public static func AugmentedSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_AugmentedSeventh.0, inversion: inversion, additions: additions)
    }
    public static let HalfDiminishedSeventh : Harmonizer = Chord.HalfDiminishedSeventh(inversion: 0, additions: [])
    public static func HalfDiminishedSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_HalfDiminishedSeventh.0, inversion: inversion, additions: additions)
    }
    public static let DiminishedSeventh : Harmonizer = Chord.DiminishedSeventh(inversion: 0, additions: [])
    public static func DiminishedSeventh(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_DiminishedSeventh.0, inversion: inversion, additions: additions)
    }
    public static let DominantSeventhFlatFive : Harmonizer = Chord.DominantSeventhFlatFive(inversion: 0, additions: [])
    public static func DominantSeventhFlatFive(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_DominantSeventhFlatFive.0, inversion: inversion, additions: additions)
    }
    public static let MajorSeventhFlatFive : Harmonizer = Chord.MajorSeventhFlatFive(inversion: 0, additions: [])
    public static func MajorSeventhFlatFive(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MajorSeventhFlatFive.0, inversion: inversion, additions: additions)
    }
    public static let DominantSeventhSusFour : Harmonizer = Chord.DominantSeventhSusFour(inversion: 0, additions: [])
    public static func DominantSeventhSusFour(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_DominantSeventhSusFour.0, inversion: inversion, additions: additions)
    }
    public static let MajorSeventhSusFour : Harmonizer = Chord.MajorSeventhSusFour(inversion: 0, additions: [])
    public static func MajorSeventhSusFour(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MajorSeventhSusFour.0, inversion: inversion, additions: additions)
    }
    public static let MajorSixth : Harmonizer = Chord.MajorSixth(inversion: 0, additions: [])
    public static func MajorSixth(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MajorSixth.0, inversion: inversion, additions: additions)
    }
    public static let MinorSixth : Harmonizer = Chord.MinorSixth(inversion: 0, additions: [])
    public static func MinorSixth(inversion: UInt = 0, additions: [ChordAddition] = []) -> Harmonizer {
        return create(_MinorSixth.0, inversion: inversion, additions: additions)
    }

}
