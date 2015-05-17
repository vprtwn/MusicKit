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

    /// Creates a new chord `Harmonizer` from the given intervals
    static func create(intervals: [Float]) -> Harmonizer {
        // convert to indices
        let originalIndices = MKUtil.semitoneIndices(intervals)
        var indices = originalIndices

        // convert to intervals
        let intervals = MKUtil.intervals(indices)

        return Harmony.create(intervals)
    }

    // triads
    public static let Major = Harmony.create(ChordQuality.Major.intervals)
    public static let Minor = Harmony.create(ChordQuality.Minor.intervals)
    public static let Augmented = Harmony.create(ChordQuality.Augmented.intervals)
    public static let Diminished = Harmony.create(ChordQuality.Diminished.intervals)
    public static let Sus2 = Harmony.create(ChordQuality.Sus2.intervals)
    public static let Sus4 = Harmony.create(ChordQuality.Sus4.intervals)
    // tetrads
    public static let DominantSeventh = Harmony.create(ChordQuality.DominantSeventh.intervals)
    public static let MajorSeventh = Harmony.create(ChordQuality.MajorSeventh.intervals)
    public static let MinorMajorSeventh = Harmony.create(ChordQuality.MinorMajorSeventh.intervals)
    public static let MinorSeventh = Harmony.create(ChordQuality.MinorSeventh.intervals)
    public static let AugmentedMajorSeventh = Harmony.create(ChordQuality.AugmentedMajorSeventh.intervals)
    public static let AugmentedSeventh = Harmony.create(ChordQuality.AugmentedSeventh.intervals)
    public static let HalfDiminishedSeventh = Harmony.create(ChordQuality.HalfDiminishedSeventh.intervals)
    public static let DiminishedSeventh = Harmony.create(ChordQuality.DiminishedSeventh.intervals)
    public static let DominantSeventhFlatFive = Harmony.create(ChordQuality.DominantSeventhFlatFive.intervals)
    public static let MajorSeventhFlatFive = Harmony.create(ChordQuality.MajorSeventhFlatFive.intervals)
    public static let DominantSeventhSusFour = Harmony.create(ChordQuality.DominantSeventhSusFour.intervals)
    public static let MajorSeventhSusFour = Harmony.create(ChordQuality.MajorSeventhSusFour.intervals)
    public static let MajorSixth = Harmony.create(ChordQuality.MajorSixth.intervals)
    public static let MinorSixth = Harmony.create(ChordQuality.MinorSixth.intervals)
    public static let AddNine = Harmony.create(ChordQuality.AddNine.intervals)
    public static let MinorAddNine = Harmony.create(ChordQuality.MinorAddNine.intervals)
    // pentads
    public static let DominantNinth = Harmony.create(ChordQuality.DominantNinth.intervals)
    public static let DominantMinorNinth = Harmony.create(ChordQuality.DominantMinorNinth.intervals)
    public static let DominantSeventhSharpNine = Harmony.create(ChordQuality.DominantSeventhSharpNine.intervals)
    public static let MajorNinth = Harmony.create(ChordQuality.MajorNinth.intervals)
    public static let MinorNinth = Harmony.create(ChordQuality.MinorNinth.intervals)
    public static let MinorMajorNinth = Harmony.create(ChordQuality.MinorMajorNinth.intervals)
    public static let AugmentedNinth = Harmony.create(ChordQuality.AugmentedNinth.intervals)
    public static let AugmentedMajorNinth = Harmony.create(ChordQuality.AugmentedMajorNinth.intervals)
    public static let HalfDiminishedNinth = Harmony.create(ChordQuality.HalfDiminishedNinth.intervals)
    public static let HalfDiminishedMinorNinth = Harmony.create(ChordQuality.HalfDiminishedMinorNinth.intervals)
    public static let DiminishedNinth = Harmony.create(ChordQuality.DiminishedNinth.intervals)
    public static let DiminishedMinorNinth = Harmony.create(ChordQuality.DiminishedMinorNinth.intervals)
    public static let SixNine = Harmony.create(ChordQuality.SixNine.intervals)
    public static let Dominant9Sus4 = Harmony.create(ChordQuality.Dominant9Sus4.intervals)
    // hexads
    public static let DominantEleventh = Harmony.create(ChordQuality.DominantEleventh.intervals)
    public static let MajorEleventh = Harmony.create(ChordQuality.MajorEleventh.intervals)
    public static let MinorMajorEleventh = Harmony.create(ChordQuality.MinorMajorEleventh.intervals)
    public static let MinorEleventh = Harmony.create(ChordQuality.MinorEleventh.intervals)
    public static let AugmentedMajorEleventh = Harmony.create(ChordQuality.AugmentedMajorEleventh.intervals)
    public static let AugmentedEleventh = Harmony.create(ChordQuality.AugmentedEleventh.intervals)
    public static let HalfDiminishedEleventh = Harmony.create(ChordQuality.HalfDiminishedEleventh.intervals)
    public static let DiminishedEleventh = Harmony.create(ChordQuality.DiminishedEleventh.intervals)
    public static let DominantNinthSharpEleven = Harmony.create(ChordQuality.DominantNinthSharpEleven.intervals)
}
