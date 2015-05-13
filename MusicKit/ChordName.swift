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

/// defines arrays of ChordQuality
struct ChordGroup {
    static let Triads = [
        ChordQuality.Major,
        ChordQuality.Minor,
        ChordQuality.Augmented,
        ChordQuality.Diminished,
        ChordQuality.Sus2,
        ChordQuality.Sus4
    ]
    static let Tetrads = [
        ChordQuality.DominantSeventh,
        ChordQuality.MajorSeventh,
        ChordQuality.MinorMajorSeventh,
        ChordQuality.MinorSeventh,
        ChordQuality.AugmentedMajorSeventh,
        ChordQuality.AugmentedSeventh,
        ChordQuality.HalfDiminishedSeventh,
        ChordQuality.DiminishedSeventh,
        ChordQuality.DominantSeventhFlatFive,
        ChordQuality.MajorSeventhFlatFive,
        ChordQuality.DominantSeventhSusFour,
        ChordQuality.MajorSeventhSusFour,
        ChordQuality.MajorSixth,
        ChordQuality.MinorSixth,
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
            return _name(pitchSet, qualities: ChordGroup.Triads, includeSlash: true)
        }
        // Tetrads
        else if count == 4 {
            let nameOpt = _name(pitchSet, qualities: ChordGroup.Tetrads, includeSlash: true)
            if let name = nameOpt {
                return name
            }
            // remove bass note and attempt to form slash chord
            let topNameOpt = _name(removedBass, qualities: ChordGroup.Triads, includeSlash: false)
            if let name = topNameOpt {
                return bassName.map { "\(name)/\($0)" }
            }
        }
        // Pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topNameOpt = _name(removedBass, qualities: ChordGroup.Tetrads, includeSlash: false)
            if let name = topNameOpt {
                return bassName.map { "\(name)/\($0)" }
            }
        }
        return nil
    }

    static func _name(pitchSet: PitchSet,
        qualities: [ChordQuality],    // the chord qualities to check
        includeSlash: Bool) -> String?
    {
        let count = pitchSet.count
        let bass = pitchSet.first()!
        let indices = pitchSet.semitoneIndices()
        // check root position chords
        for quality in qualities {
            let symbol = quality.symbol
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            if _indices == indices {
                let rootName = bass.chroma?.description
                return rootName.map { "\($0)\(symbol)" }
            }
        }
        // check inversions
        for quality in qualities {
            let symbol = quality.symbol
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            for i in 1..<count {
                let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                if inversion == indices {
                    let rootName = pitchSet[count - i].chroma?.description
                    let baseNameOpt = includeSlash ? pitchSet[0].chroma?.description : nil
                    if let baseName = baseNameOpt {
                        return rootName.map { "\($0)\(symbol)/\(baseName)" }
                    }
                    else {
                        return rootName.map { "\($0)\(symbol)" }
                    }
                }
            }
        }
        return nil
    }
}


