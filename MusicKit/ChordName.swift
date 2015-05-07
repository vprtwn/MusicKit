//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// defines arrays of (Harmonizer, ChordTuple) tuples
struct ChordTuples {
    static let Triads = [
        (Chord.Major, Chord._Major),
        (Chord.Minor, Chord._Minor),
        (Chord.Augmented, Chord._Augmented),
        (Chord.Diminished, Chord._Diminished),
        (Chord.Sus2, Chord._Sus2),
        (Chord.Sus4, Chord._Sus4)
    ]
    static let Tetrads = [
        (Chord.DominantSeventh, Chord._DominantSeventh),
        (Chord.MajorSeventh, Chord._MajorSeventh),
        (Chord.MinorMajorSeventh, Chord._MinorMajorSeventh),
        (Chord.MinorSeventh, Chord._MinorSeventh),
        (Chord.AugmentedMajorSeventh, Chord._AugmentedMajorSeventh),
        (Chord.AugmentedSeventh, Chord._AugmentedSeventh),
        (Chord.HalfDiminishedSeventh, Chord._HalfDiminishedSeventh),
        (Chord.DiminishedSeventh, Chord._DiminishedSeventh),
        (Chord.DominantSeventhFlatFive, Chord._DominantSeventhFlatFive),
        (Chord.MajorSeventhFlatFive, Chord._MajorSeventhFlatFive),
        (Chord.DominantSeventhSusFour, Chord._DominantSeventhSusFour),
        (Chord.MajorSeventhSusFour, Chord._MajorSeventhSusFour),
        (Chord.MajorSixth, Chord._MajorSixth),
        (Chord.MinorSixth, Chord._MinorSixth),
    ]
}

extension PitchSet {
    /// Normalizes the pitch set by deduping and compressing to within an octave
    /// while maintaining the root.
    mutating func normalize() {
        dedupe(); compress()
    }
}

extension Chord {
    /// Returns the name of the chord, or nil if no name can be determined.
    public static func name(pitchSet: PitchSet) -> String? {
        var pitchSet = pitchSet
        pitchSet.normalize()
        let count = pitchSet.count

        // must have at least a triad after normalization
        if count < 3 { return nil }

        // MARK: Triads
        if count < 5 {
            return nameWithoutExtensions(pitchSet)
        }
        return nil
    }

    static func nameWithoutExtensions(pitchSet: PitchSet) -> String? {
        let count = pitchSet.count
        let root = pitchSet.first()!
        let indices = pitchSet.semitoneIndices()
        let chordTuples = ChordTuples.Triads + ChordTuples.Tetrads
        // check root position chords
        for tuple in chordTuples {
            let shortSuffix = tuple.1.2
            var _indices = tuple.0(root).semitoneIndices()
            if _indices == indices {
                let rootName = root.chroma?.description
                return rootName.map { "\($0)\(shortSuffix)" }
            }
        }
        // check inversions
        for tuple in chordTuples {
            let shortSuffix = tuple.1.2
            let _pitchSet = tuple.0(root)
            var _indices = tuple.0(root).semitoneIndices()
            for i in 1..<count {
                let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                if inversion == indices {
                    let rootName = pitchSet[count - i].chroma?.description
                    let bottomNameOpt = pitchSet[0].chroma?.description
                    if let bottomName = bottomNameOpt {
                        return rootName.map { "\($0)\(shortSuffix)/\(bottomName)" }
                    }
                }
            }
        }
        return nil
    }
}


