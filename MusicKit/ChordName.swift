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
    /// Returns the name of the chord or nil
    public static func name(pitchSet: PitchSet) -> String? {
        if let tuple = parse(pitchSet) {
            let rootNameOpt = tuple.1.chroma?.description
            if tuple.1 == tuple.2 {
                return rootNameOpt.map { "\($0)\(tuple.0.symbol)" }
            }
            if let bassName = tuple.2.chroma?.description {
                return rootNameOpt.map { "\($0)\(tuple.0.symbol)/\(bassName)" }
            }
        }
        return nil
    }

    /// If a ChordQuality matching this chord is found, returns a tuple with 
    /// the chord's (quality, root, bass). Otherwise, returns nil.
    public static func parse(pitchSet: PitchSet) -> (ChordQuality, Pitch, Pitch)? {
        var pitchSet = pitchSet
        pitchSet.normalize()
        let count = pitchSet.count
        let gamutCount = pitchSet.gamut().count

        // early return if:
        // - less than a triad after normalization
        // - one or more pitch is chroma-less
        if count < 3 || count != gamutCount { return nil }

        let bass = pitchSet[0]
        var removedBass = pitchSet
        removedBass.remove(bass)

        // Triads
        if count == 3 {
            return _parse(pitchSet, qualities: ChordGroup.Triads, includeSlash: true)
        }
        // Tetrads
        else if count == 4 {
            let fullOpt = _parse(pitchSet, qualities: ChordGroup.Tetrads, includeSlash: true)
            if let full = fullOpt {
                return full
            }
            // remove bass note and attempt to form slash chord
            let topOpt = _parse(removedBass, qualities: ChordGroup.Triads, includeSlash: false)
            if let top = topOpt {
                return (top.0, top.1, bass)
            }
        }
        // Pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topOpt = _parse(removedBass, qualities: ChordGroup.Tetrads, includeSlash: false)
            if let top = topOpt {
                return (top.0, top.1, bass)
            }
        }
        return nil
    }

    /// Returns an optional (quality, root, bass)
    static func _parse(pitchSet: PitchSet,
        qualities: [ChordQuality],
        includeSlash: Bool) -> (ChordQuality, Pitch, Pitch)?
    {
        let count = pitchSet.count
        let bass = pitchSet.first()!
        let indices = pitchSet.semitoneIndices()
        // check root position chords
        for quality in qualities {
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            if _indices == indices {
                let rootName = bass.chroma?.description
                return (quality, bass, bass)
            }
        }
        // check inversions
        for quality in qualities {
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            for i in 1..<count {
                let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                if inversion == indices {
                    let root = pitchSet[count - i]
                    return (quality, root, bass)
                }
            }
        }
        return nil
    }
}


