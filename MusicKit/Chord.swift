//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

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

    /// Creates a new chord `Harmonizer` from the given intervals, inversion, and extensions
    static func create(intervals: [Float], inversion: UInt) -> Harmonizer {
        // convert to indices
        let originalIndices = MKUtil.semitoneIndices(intervals)
        var indices = originalIndices

        // invert
        let inversion = Int(inversion) % indices.count
        indices = MKUtil.invert(indices, n: UInt(inversion))

        // convert to intervals
        let intervals = MKUtil.intervals(indices)

        return Harmony.transpose(Harmony.create(intervals), semitones: originalIndices[inversion])
    }

    /// TODO: autogenerate the code below using ChordQuality
    //MARK: Triads
    public static let Major : Harmonizer = Chord.Major(inversion: 0)
    public static func Major(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Major.intervals, inversion: inversion)
    }
    public static let Minor : Harmonizer = Chord.Minor(inversion: 0)
    public static func Minor(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Minor.intervals, inversion: inversion)
    }
    public static let Augmented : Harmonizer = Chord.Augmented(inversion: 0)
    public static func Augmented(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Augmented.intervals, inversion: inversion)
    }
    public static let Diminished : Harmonizer = Chord.Diminished(inversion: 0)
    public static func Diminished(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Diminished.intervals, inversion: inversion)
    }
    public static let Sus2 : Harmonizer = Chord.Sus2(inversion: 0)
    public static func Sus2(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Sus2.intervals, inversion: inversion)
    }
    public static let Sus4 : Harmonizer = Chord.Sus4(inversion: 0)
    public static func Sus4(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Sus4.intervals, inversion: inversion)
    }
    //MARK: Tetrads
    public static let DominantSeventh : Harmonizer = Chord.DominantSeventh(inversion: 0)
    public static func DominantSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantSeventh.intervals, inversion: inversion)
    }
    public static let MajorSeventh : Harmonizer = Chord.MajorSeventh(inversion: 0)
    public static func MajorSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorSeventh.intervals, inversion: inversion)
    }
    public static let MinorMajorSeventh : Harmonizer = Chord.MinorMajorSeventh(inversion: 0)
    public static func MinorMajorSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorMajorSeventh.intervals, inversion: inversion)
    }
    public static let MinorSeventh : Harmonizer = Chord.MinorSeventh(inversion: 0)
    public static func MinorSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorSeventh.intervals, inversion: inversion)
    }
    public static let AugmentedMajorSeventh : Harmonizer = Chord.AugmentedMajorSeventh(inversion: 0)
    public static func AugmentedMajorSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedMajorSeventh.intervals, inversion: inversion)
    }
    public static let AugmentedSeventh : Harmonizer = Chord.AugmentedSeventh(inversion: 0)
    public static func AugmentedSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedSeventh.intervals, inversion: inversion)
    }
    public static let HalfDiminishedSeventh : Harmonizer = Chord.HalfDiminishedSeventh(inversion: 0)
    public static func HalfDiminishedSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.HalfDiminishedSeventh.intervals, inversion: inversion)
    }
    public static let DiminishedSeventh : Harmonizer = Chord.DiminishedSeventh(inversion: 0)
    public static func DiminishedSeventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DiminishedSeventh.intervals, inversion: inversion)
    }
    public static let DominantSeventhFlatFive : Harmonizer = Chord.DominantSeventhFlatFive(inversion: 0)
    public static func DominantSeventhFlatFive(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantSeventhFlatFive.intervals, inversion: inversion)
    }
    public static let MajorSeventhFlatFive : Harmonizer = Chord.MajorSeventhFlatFive(inversion: 0)
    public static func MajorSeventhFlatFive(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorSeventhFlatFive.intervals, inversion: inversion)
    }
    public static let DominantSeventhSusFour : Harmonizer = Chord.DominantSeventhSusFour(inversion: 0)
    public static func DominantSeventhSusFour(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantSeventhSusFour.intervals, inversion: inversion)
    }
    public static let MajorSeventhSusFour : Harmonizer = Chord.MajorSeventhSusFour(inversion: 0)
    public static func MajorSeventhSusFour(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorSeventhSusFour.intervals, inversion: inversion)
    }
    public static let MajorSixth : Harmonizer = Chord.MajorSixth(inversion: 0)
    public static func MajorSixth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorSixth.intervals, inversion: inversion)
    }
    public static let MinorSixth : Harmonizer = Chord.MinorSixth(inversion: 0)
    public static func MinorSixth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorSixth.intervals, inversion: inversion)
    }
    public static let AddNine : Harmonizer = Chord.AddNine(inversion: 0)
    public static func AddNine(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AddNine.intervals, inversion: inversion)
    }
    public static let MinorAddNine : Harmonizer = Chord.MinorAddNine(inversion: 0)
    public static func MinorAddNine(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorAddNine.intervals, inversion: inversion)
    }
    //MARK: Pentads
    public static let DominantNinth : Harmonizer = Chord.DominantNinth(inversion: 0)
    public static func DominantNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantNinth.intervals, inversion: inversion)
    }
    public static let DominantMinorNinth : Harmonizer = Chord.DominantMinorNinth(inversion: 0)
    public static func DominantMinorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantMinorNinth.intervals, inversion: inversion)
    }
    public static let DominantSeventhSharpNine : Harmonizer = Chord.DominantSeventhSharpNine(inversion: 0)
    public static func DominantSeventhSharpNine(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantMinorNinth.intervals, inversion: inversion)
    }
    public static let MajorNinth : Harmonizer = Chord.MajorNinth(inversion: 0)
    public static func MajorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorNinth.intervals, inversion: inversion)
    }
    public static let MinorNinth : Harmonizer = Chord.MinorNinth(inversion: 0)
    public static func MinorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorNinth.intervals, inversion: inversion)
    }
    public static let MinorMajorNinth : Harmonizer = Chord.MinorMajorNinth(inversion: 0)
    public static func MinorMajorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorMajorNinth.intervals, inversion: inversion)
    }
    public static let AugmentedNinth : Harmonizer = Chord.AugmentedNinth(inversion: 0)
    public static func AugmentedNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedNinth.intervals, inversion: inversion)
    }
    public static let AugmentedMajorNinth : Harmonizer = Chord.AugmentedMajorNinth(inversion: 0)
    public static func AugmentedMajorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedMajorNinth.intervals, inversion: inversion)
    }
    public static let HalfDiminishedNinth : Harmonizer = Chord.HalfDiminishedNinth(inversion: 0)
    public static func HalfDiminishedNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.HalfDiminishedNinth.intervals, inversion: inversion)
    }
    public static let HalfDiminishedMinorNinth : Harmonizer = Chord.HalfDiminishedMinorNinth(inversion: 0)
    public static func HalfDiminishedMinorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.HalfDiminishedMinorNinth.intervals, inversion: inversion)
    }
    public static let DiminishedNinth : Harmonizer = Chord.DiminishedNinth(inversion: 0)
    public static func DiminishedNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DiminishedNinth.intervals, inversion: inversion)
    }
    public static let DiminishedMinorNinth : Harmonizer = Chord.DiminishedMinorNinth(inversion: 0)
    public static func DiminishedMinorNinth(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DiminishedMinorNinth.intervals, inversion: inversion)
    }
    public static let SixNine : Harmonizer = Chord.SixNine(inversion: 0)
    public static func SixNine(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.SixNine.intervals, inversion: inversion)
    }
    public static let Dominant9sus4 : Harmonizer = Chord.Dominant9sus4(inversion: 0)
    public static func Dominant9sus4(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.Dominant9Sus4.intervals, inversion: inversion)
    }
    //MARK: Hexads
    public static let DominantEleventh : Harmonizer = Chord.DominantEleventh(inversion: 0)
    public static func DominantEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantEleventh.intervals, inversion: inversion)
    }
    public static let MajorEleventh : Harmonizer = Chord.MajorEleventh(inversion: 0)
    public static func MajorEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MajorEleventh.intervals, inversion: inversion)
    }
    public static let MinorMajorEleventh : Harmonizer = Chord.MinorMajorEleventh(inversion: 0)
    public static func MinorMajorEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorMajorEleventh.intervals, inversion: inversion)
    }
    public static let MinorEleventh : Harmonizer = Chord.MinorEleventh(inversion: 0)
    public static func MinorEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.MinorEleventh.intervals, inversion: inversion)
    }
    public static let AugmentedMajorEleventh : Harmonizer = Chord.AugmentedMajorEleventh(inversion: 0)
    public static func AugmentedMajorEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedMajorEleventh.intervals, inversion: inversion)
    }
    public static let AugmentedEleventh : Harmonizer = Chord.AugmentedEleventh(inversion: 0)
    public static func AugmentedEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.AugmentedEleventh.intervals, inversion: inversion)
    }
    public static let HalfDiminishedEleventh : Harmonizer = Chord.HalfDiminishedEleventh(inversion: 0)
    public static func HalfDiminishedEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.HalfDiminishedEleventh.intervals, inversion: inversion)
    }
    public static let DiminishedEleventh : Harmonizer = Chord.DiminishedEleventh(inversion: 0)
    public static func DiminishedEleventh(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DiminishedEleventh.intervals, inversion: inversion)
    }
    public static let DominantNinthSharpEleven : Harmonizer = Chord.DominantNinthSharpEleven(inversion: 0)
    public static func DominantNinthSharpEleven(inversion: UInt = 0) -> Harmonizer {
        return create(ChordQuality.DominantNinthSharpEleven.intervals, inversion: inversion)
    }
    //MARK: Heptads
}
