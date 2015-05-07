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
    /// Creates a new `Harmonizer` using the (1-indexed) indices of the given harmonizer
    public static func create(harmonizer: Harmonizer, indices: [UInt]) -> Harmonizer {
        if indices.count < 2 || contains(indices, 0) {
            return Harmony.IdentityHarmonizer
        }

        // sort and convert to zero-indexed indices
        let sortedIndices = sorted(indices.map { $0 - 1 })
        let maxIndex = Int(sortedIndices.last!)
        var scalePitches = harmonizer(Chroma.C*0)

        // extend scale until it covers the max index
        while (scalePitches.count < maxIndex + 1) {
            scalePitches.extendOctaves(1)
        }

        let chosenPitches = PitchSet(sortedIndices.map { scalePitches[Int($0)] })
        return Harmony.create(MKUtil.intervals(chosenPitches.semitoneIndices()))
    }

    /// Creates a new chord `Harmonizer` from the given intervals, inversion, and additions
    static func create(intervals: [Float], inversion: UInt, additions: [ChordAddition]) -> Harmonizer {
        // convert to indices
        let originalIndices = MKUtil.semitoneIndices(intervals)
        var indices = originalIndices + additions.map { $0.rawValue }

        // invert
        let inversion = Int(inversion) % indices.count
        indices = MKUtil.invert(indices, n: UInt(inversion))

        // convert to intervals
        let intervals = MKUtil.intervals(indices)

        return Harmony.transpose(Harmony.create(intervals), semitones: originalIndices[inversion])
    }

    static let _Major : ChordTuple = ([4, 3], "major triad", "M")
    static let _Minor : ChordTuple = ([3, 4], "minor triad", "m")
    static let _Augmented : ChordTuple = ([4, 4], "augmented triad", "+")
    static let _Diminished : ChordTuple = ([3, 3], "diminished triad", "°")
    static let _Sus2 : ChordTuple = ([2, 5], "suspended second", "sus2")
    static let _Sus4 : ChordTuple = ([5, 2], "suspended fourth", "sus4")

    static let _DominantSeventh : ChordTuple = ([4, 3, 3], "dominant seventh", "7")
    static let _MajorSeventh : ChordTuple = ([4, 3, 4], "major seventh", "Δ7")
    static let _MinorMajorSeventh : ChordTuple = ([3, 4, 4], "minor-major seventh", "mΔ7")
    static let _MinorSeventh : ChordTuple = ([3, 4, 3], "minor seventh", "m7")
    static let _AugmentedMajorSeventh : ChordTuple = ([4, 4, 3], "augmented-major seventh", "+Δ7")
    static let _AugmentedSeventh : ChordTuple = ([4, 4, 2], "augmented seventh", "+7")
    static let _HalfDiminishedSeventh : ChordTuple = ([3, 3, 4], "half-diminished seventh", "ø7")
    static let _DiminishedSeventh : ChordTuple = ([3, 3, 3], "diminished seventh", "°")
    static let _DominantSeventhFlatFive : ChordTuple = ([4, 2, 4], "dominant seventh flat five", "7♭5")
    static let _MajorSeventhFlatFive : ChordTuple = ([5, 2, 4], "major seventh flat five", "Δ7♭5")
    static let _DominantSeventhSusFour : ChordTuple = ([5, 2, 3], "dominant seventh sus four", "7sus4")
    static let _MajorSeventhSusFour : ChordTuple = ([5, 2, 4], "major seventh sus four", "Δ7sus4")
    static let _MajorSixth : ChordTuple = ([4, 3, 2], "major sixth", "6")
    static let _MinorSixth : ChordTuple = ([3, 4, 2], "minor sixth", "m6")

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
