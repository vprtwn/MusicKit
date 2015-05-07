//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

struct ChordExtensions {
    static let SingleExtensions = [
        [ChordExtension.FlatNine],
        [ChordExtension.Nine],
        [ChordExtension.SharpEleven],
        [ChordExtension.FlatThirteen],
        [ChordExtension.Thirteen],
    ]
}

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
        let gamutCount = pitchSet.gamut().count

        // early return if:
        // - less than a triad after normalization
        // - one or more pitch is chroma-less
        if count < 3 || count != gamutCount { return nil }

        let bass = pitchSet.first()!
        let bassName = bass.chroma?.description
        var removedBass = pitchSet
        removedBass.remove(bass)

        // Triads
        if count == 3 {
            return _name(pitchSet, tuples: ChordTuples.Triads, includeSlash: true)
        }
        // Tetrads
        else if count == 4 {
            let nameOpt = _name(pitchSet, tuples: ChordTuples.Tetrads, includeSlash: true)
            if let name = nameOpt {
                return name
            }
            // remove bass note and attempt to form slash chord
            let topNameOpt = _name(removedBass, tuples: ChordTuples.Triads, includeSlash: false)
            if let name = topNameOpt {
                return bassName.map { "\(name)/\($0)" }
            }
            // try with one extension
            /// TODO: should limit chords that can be extended to common ones (major/minor/dominant)
            let extNameOpt = _name(pitchSet, tuples: ChordTuples.Triads,
                extensions: ChordExtensions.SingleExtensions, includeSlash: false)
            if let name = extNameOpt {
                return name
            }
        }
        // Pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topNameOpt = _name(removedBass, tuples: ChordTuples.Tetrads, includeSlash: false)
            if let name = topNameOpt {
                return bassName.map { "\(name)/\($0)" }
            }
        }
        return nil
    }

    static func _name(pitchSet: PitchSet,
        tuples: [(Harmonizer, ChordTuple)],    // the tuples to check
        extensions: [[ChordExtension]] = [[]], // the chord extensions to check
        includeSlash: Bool) -> String?
    {
        for ext in extensions {
            let extIndices = ext.map { $0.rawValue }
            let extName = ext.reduce("", combine: { (name, ext) -> String in
                name + ext.description
            })
            let count = pitchSet.count
            let bass = pitchSet.first()!
            let indices = pitchSet.semitoneIndices()
            // check root position chords
            for tuple in tuples {
                let suffix = tuple.1.2
                var _indices = MKUtil.compress(tuple.0(bass).semitoneIndices() + extIndices)
                if _indices == indices {
                    let rootName = bass.chroma?.description
                    return rootName.map { "\($0)\(suffix)\(extName)" }
                }
            }
            // check inversions
            for tuple in tuples {
                let suffix = tuple.1.2
                let _pitchSet = tuple.0(bass)
                var _indices = tuple.0(bass).semitoneIndices()
                for i in 1..<count {
                    let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                    if inversion == indices {
                        let rootName = pitchSet[count - i].chroma?.description
                        let baseNameOpt = includeSlash ? pitchSet[0].chroma?.description : nil
                        if let baseName = baseNameOpt {
                            return rootName.map { "\($0)\(suffix)/\(baseName)" }
                        }
                        else {
                            return rootName.map { "\($0)\(suffix)" }
                        }
                    }
                }
            }
        }
        return nil
    }
}


