//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

extension Chord {
    /// Creates a new `Harmonizer` using the (1-indexed) indices of the given harmonizer
    public static func create(_ harmonizer: Harmonizer, indices: [UInt]) -> Harmonizer {
        if indices.count < 2 || indices.contains(0) {
            return Harmony.IdentityHarmonizer
        }

        // sort and convert to zero-indexed indices
        let sortedIndices = (indices.map { $0 - 1 }).sorted()
        let maxIndex = Int(sortedIndices.last!)
        var scalePitches = harmonizer(Chroma.c*0)

        // extend scale until it covers the max index
        while (scalePitches.count < maxIndex + 1) {
            scalePitches = scalePitches.extend(1)
        }

        let chosenPitches = PitchSet(sortedIndices.map { scalePitches[Int($0)] })
        return Harmony.create(MKUtil.intervals(chosenPitches.semitoneIndices()))
    }
}
