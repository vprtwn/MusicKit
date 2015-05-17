//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

extension Chord {
    /// Creates a new `Harmonizer` using the (1-indexed) indices of the given harmonizer
    public static func create(harmonizer: Harmonizer, indices: [UInt]) -> Harmonizer {
        if indices.count < 2 || contains(indices, 0) {
            return Harmony.IdentityHarmonizer
        }

        // sort and convert to zero-indexed indices
        let sortedIndices = sorted(indices.map { $0 - 1 })
        let maxIndex = Int(sortedIndices.last!)
        var scalePitches = harmonizer(Chroma.C*0)

        // extend scale until it covers the max index
        while (scalePitches.count < maxIndex + 1) {
            scalePitches.extendOctaves(1)
        }

        let chosenPitches = PitchSet(sortedIndices.map { scalePitches[Int($0)] })
        return Harmony.create(MKUtil.intervals(chosenPitches.semitoneIndices()))
    }
}
