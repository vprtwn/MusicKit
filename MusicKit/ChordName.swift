//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

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
            let quality = desc.quality.description
            if desc.root == desc.bass {
                return "\(rootName)\(quality)"
            }
            else {
                let bassName = desc.bass.description
                return "\(rootName)\(quality)/\(bassName)"
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
        // - less than a dyad after normalization
        // - one or more pitch is chroma-less
        if count < 2 || count != gamutCount { return nil }

        let bass = pitchSet[0]
        let bassChromaOpt = bass.chroma
        var removedBass = pitchSet
        removedBass.remove(bass)

        // dyads
        if count == 2 {
            return _descriptor(pitchSet, qualities: ChordQuality.Dyads)
        }
        // triads
        else if count == 3 {
            return _descriptor(pitchSet, qualities: ChordQuality.Triads)
        }
        // Tetrads
        else if count == 4 {
            // no-slash chord
            let fullDescOpt = _descriptor(pitchSet, qualities: ChordQuality.Tetrads)
            // slash chord
            let topDescOpt = _descriptor(removedBass, qualities: ChordQuality.Triads)
            var slashDescOpt : ChordDescriptor? = nil
            if let topDesc = topDescOpt {
                slashDescOpt = bassChromaOpt.map {
                    ChordDescriptor(root: topDesc.root, quality: topDesc.quality, bass: $0)
                }
            }
            // unaltered no-slash chord
            if let fullDesc = fullDescOpt {
                if contains(ChordQuality.UnalteredTetrads, fullDesc.quality) {
                    return fullDesc
                }
            }
            // slash chord > altered no-slash chord
            return slashDescOpt != nil ? slashDescOpt : fullDescOpt
        }
        // pentads
        else if count == 5 {
            // remove bass note and attempt to form slash chord
            let topDescOpt = _descriptor(removedBass, qualities: ChordQuality.Tetrads)
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


