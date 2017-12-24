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
    public static func name(_ pitchSet: PitchSet) -> String? {
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
    public static func descriptor(_ pitchSet: PitchSet) -> ChordDescriptor? {
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
        // pitch set with bass removed
        var bassRemoved = pitchSet
        _ =  bassRemoved.remove(bass)

        // dyads
        if count == 2 {
            return _descriptor(pitchSet, qualities: ChordQuality.Dyads)
        }
        // triads
        else if count == 3 {
            return _descriptor(pitchSet, qualities: ChordQuality.Triads)
        }
        // Tetrads, Pentads, Hexads, Heptads
        else if count > 3 && count < 8 {
            var fullQs = [ChordQuality]()
            var fullUnalteredQs = [ChordQuality]()
            var slashQs = [ChordQuality]()
            if count == 4 {
                fullQs = ChordQuality.Tetrads
                fullUnalteredQs = ChordQuality.UnalteredTetrads
                slashQs = ChordQuality.Triads
            } else if count == 5 {
                fullQs = ChordQuality.Pentads
                fullUnalteredQs = ChordQuality.UnalteredPentads
                slashQs = ChordQuality.Tetrads
            } else if count == 6 {
                fullQs = ChordQuality.Hexads
                fullUnalteredQs = ChordQuality.UnalteredHexads
                slashQs = ChordQuality.Pentads
            } else if count == 7 {
                fullQs = ChordQuality.Heptads
                fullUnalteredQs = ChordQuality.UnalteredHeptads
                slashQs = ChordQuality.Hexads
            }
            // no-slash
            let fullOpt = _descriptor(pitchSet, qualities: fullQs)
            // unaltered, no-slash, root position -> return
            if let full = fullOpt {
                if fullUnalteredQs.contains(full.quality) &&
                    full.bass == full.root {
                    return full
                }
            }
            // try to simplify chord by slashing
            let noBassOpt = _descriptor(bassRemoved, qualities: slashQs)
            var slashNoBassOpt: ChordDescriptor? = nil
            if let noBass = noBassOpt {
                slashNoBassOpt = bassChromaOpt.map {
                    ChordDescriptor(root: noBass.root, quality: noBass.quality, bass: $0)
                }
            }
            return slashNoBassOpt ?? fullOpt
        }
        return nil
    }

    /// Returns an optional `ChordDescriptor`.
    static func _descriptor(_ pitchSet: PitchSet,
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


