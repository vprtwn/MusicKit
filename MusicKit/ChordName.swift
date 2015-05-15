//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

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
        dedupe()
        collapse()
    }
}

extension Chord {
    /// Returns the name of the chord if found.
    public static func name(pitchSet: PitchSet) -> String? {
        if let desc = descriptor(pitchSet) {
            let rootName = desc.root.description
            let symbol = desc.quality.symbol
            if desc.root == desc.bass {
                return "\(rootName)\(symbol)"
            }
            else {
                let bassName = desc.bass.description
                return "\(rootName)\(symbol)/\(bassName)"
            }
        }
        return nil
    }

    /// Returns an optional `ChordDescriptor`.
    public static func descriptor(pitchSet: PitchSet) -> ChordDescriptor? {
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
            return _descriptor(pitchSet, qualities: ChordGroup.Triads)
        }
        // Tetrads
        else if count == 4 {
            let fullDescOpt = _descriptor(pitchSet, qualities: ChordGroup.Tetrads)
            if let fullDesc = fullDescOpt {
                return fullDesc
            }
            // remove bass note and attempt to form slash chord
            let topDescOpt = _descriptor(removedBass, qualities: ChordGroup.Triads)
            if let topDesc = topDescOpt {
                return bassChromaOpt.map {
                    ChordDescriptor(root: topDesc.root, quality: topDesc.quality, bass: $0)
                }
            }
        }
        // Pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topDescOpt = _descriptor(removedBass, qualities: ChordGroup.Tetrads)
            if let topDesc = topDescOpt {
                return bassChromaOpt.map {
                    ChordDescriptor(root: topDesc.root, quality: topDesc.quality, bass: $0)
                }
            }
        }
        return nil
    }

    /// Returns an optional `ChordDescriptor`.
    static func _descriptor(pitchSet: PitchSet,
        qualities: [ChordQuality]) -> ChordDescriptor?
    {
        let count = pitchSet.count
        if count < 1 {
            return nil
        }

        let bass = pitchSet.first()!
        let bassChromaOpt = bass.chroma

        let indices = pitchSet.semitoneIndices()
        // check root position chords
        for quality in qualities {
            let _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            if _indices == indices {
                return bassChromaOpt.map {
                    ChordDescriptor(root: $0, quality: quality, bass: $0)
                }
            }
        }
        // check inversions
        for quality in qualities {
            let _indices = MKUtil.collapse(MKUtil.semitoneIndices(quality.intervals))
            for i in 1..<count {
                let inversion = MKUtil.zero(MKUtil.invert(_indices, n: UInt(i)))
                if inversion == indices {
                    if let rootChroma = pitchSet[count - i].chroma {
                        return bassChromaOpt.map {
                            ChordDescriptor(root: rootChroma, quality: quality, bass: $0)
                        }
                    }
                }
            }
        }
        return nil
    }
}


