//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct Chord : Printable {
    /// Intervals of tones in semitones relative to the root
    public let intervals : [Float]
    public let name : String
    public let inversion : UInt

    public init(intervals: [Float], name: String = "", inversion: UInt = 0) {
        self.intervals = intervals
        self.name = name
        self.inversion = inversion
    }

    public var description : String {
        return "\(name)"
    }

    public func inversion(n: UInt) -> Chord {
        let modN = n % UInt(intervals.count)
        var inverted : [Float] = intervals
        if modN > inversion {
            for i in inversion..<modN {
                inverted = inverted.rotate(1)
                inverted[inverted.count-1] += 12
            }
        }
        else if modN < inversion {
            for i in modN..<inversion {
                inverted = inverted.rotate(-1)
                inverted[0] -= 12
            }
        }
        return Chord(intervals: inverted, name: name, inversion: modN)
    }

    public static let Triads : [Chord] = [Chord.MajorTriad,
    Chord.MinorTriad, Chord.AugmentedTriad, Chord.DiminishedTriad]
    public static let MajorTriad = Chord(intervals: [0, 4, 7],
        name: "Major triad")
    public static let MinorTriad = Chord(intervals: [0, 3, 7],
        name: "Minor triad")
    public static let AugmentedTriad = Chord(intervals: [0, 4, 8],
        name: "Augmented triad")
    public static let DiminishedTriad = Chord(intervals: [0, 3, 6],
        name: "Diminished triad")

    public static let Tetrads : [Chord] = [Chord.DominantSeventh,
        Chord.MajorSeventh, Chord.MinorMajorSeventh, Chord.MinorSeventh,
        Chord.AugmentedMajorSeventh, Chord.AugmentedSeventh,
        Chord.HalfDiminishedSeventh, Chord.DiminishedSeventh,
        Chord.DominantSeventhFlatFive]
    public static let DominantSeventh = Chord(intervals: [0, 4, 7, 10],
        name: "Dominant seventh")
    public static let MajorSeventh = Chord(intervals: [0, 4, 7, 11],
        name: "Major seventh")
    public static let MinorMajorSeventh = Chord(intervals: [0, 3, 7, 11],
        name: "Minor-major seventh")
    public static let MinorSeventh = Chord(intervals: [0, 3, 7, 10],
        name: "Minor seventh")
    public static let AugmentedMajorSeventh = Chord(intervals: [0, 4, 8, 11],
        name: "Augmented-major seventh")
    public static let AugmentedSeventh = Chord(intervals: [0, 4, 8, 10],
        name: "Augmented seventh")
    public static let HalfDiminishedSeventh = Chord(intervals: [0, 3, 6, 10],
        name: "Half-diminished seventh")
    public static let DiminishedSeventh = Chord(intervals: [0, 3, 6, 9],
        name: "Diminished seventh")
    public static let DominantSeventhFlatFive = Chord(intervals: [0, 4, 6, 10],
        name: "Dominant seventh flat five")

    public static let Pentads : [Chord] = [Chord.DominantNinth,
        Chord.DominantSeventhFlatNine, Chord.MajorNinth,
        Chord.MajorSeventhFlatNine, Chord.MinorMajorNinth,
        Chord.MinorMajorSeventhFlatNine, Chord.MinorNinth,
        Chord.MinorSeventhFlatNine, Chord.AugmentedMajorNinth,
        Chord.AugmentedMajorSeventhFlatNine, Chord.AugmentedNinth,
        Chord.AugmentedSeventhFlatNine, Chord.HalfDiminishedNinth,
        Chord.HalfDiminishedSeventhFlatNine, Chord.DiminishedNinth,
        Chord.DiminishedSeventhFlatNine]
    public static let DominantNinth = Chord(intervals: [0, 4, 7, 10, 14],
        name: "Dominant ninth")
    public static let DominantSeventhFlatNine = Chord(intervals: [0, 4, 7, 10, 13],
        name: "Dominant seventh flat nine")
    public static let MajorNinth = Chord(intervals: [0, 4, 7, 11, 14],
        name: "Major ninth")
    public static let MajorSeventhFlatNine = Chord(intervals: [0, 4, 7, 11, 13],
        name: "Major seventh flat nine")
    public static let MinorMajorNinth = Chord(intervals: [0, 3, 7, 11, 14],
        name: "Minor-major ninth")
    public static let MinorMajorSeventhFlatNine = Chord(intervals: [0, 3, 7, 11, 13],
        name: "Minor-major seventh flat nine")
    public static let MinorNinth = Chord(intervals: [0, 3, 7, 10, 14],
        name: "Minor ninth")
    public static let MinorSeventhFlatNine = Chord(intervals: [0, 3, 7, 10, 13],
        name: "Minor seventh flat nine")
    public static let AugmentedMajorNinth = Chord(intervals: [0, 4, 8, 11, 14],
        name: "Augmented-major ninth")
    public static let AugmentedMajorSeventhFlatNine = Chord(intervals: [0, 4, 8, 11, 13],
        name: "Augmented-major seventh flat nine")
    public static let AugmentedNinth = Chord(intervals: [0, 4, 8, 10, 14],
        name: "Augmented ninth")
    public static let AugmentedSeventhFlatNine = Chord(intervals: [0, 4, 8, 10, 13],
        name: "Augmented seventh flat nine")
    public static let HalfDiminishedNinth = Chord(intervals: [0, 3, 6, 10, 14],
        name: "Half-diminished ninth")
    public static let HalfDiminishedSeventhFlatNine = Chord(intervals: [0, 3, 6, 10, 13],
        name: "Half-diminished seventh flat nine")
    public static let DiminishedNinth = Chord(intervals: [0, 3, 6, 9, 14],
        name: "Diminished ninth")
    public static let DiminishedSeventhFlatNine = Chord(intervals: [0, 3, 6, 9, 13],
        name: "Diminished seventh flat nine")

}
