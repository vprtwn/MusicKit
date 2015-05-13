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
            let rootName = tuple.1.description
            if tuple.1 == tuple.2 {
                return "\(rootName)\(tuple.0.symbol)"
            }
            else {
                let bassName = tuple.2.description
                return "\(rootName)\(tuple.0.symbol)/\(bassName)"
            }
        }
        return nil
    }

    /// If a ChordQuality matching this chord is found, returns a tuple with 
    /// the chord's (quality, root, bass). Otherwise, returns nil.
    public static func parse(pitchSet: PitchSet) -> (ChordQuality, Chroma, Chroma)? {
        var pitchSet = pitchSet
        pitchSet.normalize()
        let count = pitchSet.count
        let gamutCount = pitchSet.gamut().count

        // early return if:
        // - less than a triad after normalization
        // - one or more pitch is chroma-less
        if count < 3 || count != gamutCount { return nil }

        let bass = pitchSet[0]
        let bassChromaOpt = bass.chroma
        var removedBass = pitchSet
        removedBass.remove(bass)

        // Triads
        if count == 3 {
            return _parse(pitchSet, qualities: ChordGroup.Triads)
        }
        // Tetrads
        else if count == 4 {
            let fullOpt = _parse(pitchSet, qualities: ChordGroup.Tetrads)
            if let full = fullOpt {
                return full
            }
            // remove bass note and attempt to form slash chord
            let topOpt = _parse(removedBass, qualities: ChordGroup.Triads)
            if let top = topOpt {
                return bassChromaOpt.map { (top.0, top.1, $0) }
            }
        }
        // Pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topOpt = _parse(removedBass, qualities: ChordGroup.Tetrads)
            if let top = topOpt {
                return bassChromaOpt.map { (top.0, top.1, $0) }
            }
        }
        return nil
    }

    /// Returns an optional (quality, root, bass)
    static func _parse(pitchSet: PitchSet,
        qualities: [ChordQuality]) -> (ChordQuality, Chroma, Chroma)?
    {
        let count = pitchSet.count
        if count < 1 { return nil }
        let bass = pitchSet.first()!
        let bassChromaOpt = bass.chroma

        let indices = pitchSet.semitoneIndices()
        // check root position chords
        for quality in qualities {
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            if _indices == indices {
                return bassChromaOpt.map { (quality, $0, $0) }
            }
        }
        // check inversions
        for quality in qualities {
            var _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            for i in 1..<count {
                let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                if inversion == indices {
                    if let rootChroma = pitchSet[count - i].chroma {
                        return bassChromaOpt.map { (quality, rootChroma, $0) }
                    }
                }
            }
        }
        return nil
    }
}


