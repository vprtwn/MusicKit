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
        (Chord._Major),
        (Chord._Minor),
        (Chord._Augmented),
        (Chord._Diminished),
        (Chord._Sus2),
        (Chord._Sus4)
    ]
    static let Tetrads = [
        (Chord._DominantSeventh),
        (Chord._MajorSeventh),
        (Chord._MinorMajorSeventh),
        (Chord._MinorSeventh),
        (Chord._AugmentedMajorSeventh),
        (Chord._AugmentedSeventh),
        (Chord._HalfDiminishedSeventh),
        (Chord._DiminishedSeventh),
        (Chord._DominantSeventhFlatFive),
        (Chord._MajorSeventhFlatFive),
        (Chord._DominantSeventhSusFour),
        (Chord._MajorSeventhSusFour),
        (Chord._MajorSixth),
        (Chord._MinorSixth),
    ]
}

extension PitchSet {
    /// Normalizes the pitch set by deduping and collapsing to within an octave
    /// while maintaining the root.
    mutating func normalize() {
        dedupe(); collapse()
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

        let bass = pitchSet[0]
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
        tuples: [ChordTuple],    // the tuples to check
        includeSlash: Bool) -> String?
    {
        let count = pitchSet.count
        let bass = pitchSet.first()!
        let indices = pitchSet.semitoneIndices()
        // check root position chords
        for tuple in tuples {
            let suffix = tuple.2
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(tuple.0))
            if _indices == indices {
                let rootName = bass.chroma?.description
                return rootName.map { "\($0)\(suffix)" }
            }
        }
        // check inversions
        for tuple in tuples {
            let suffix = tuple.2
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(tuple.0))
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
        return nil
    }
}


