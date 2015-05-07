//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum MKUtil {
    /// Rotates the array `n` times to the right
    static func rotate<T>(array: [T],_ n: Int) -> [T] {
        let count = array.count
        let index = (n >= 0) ? n % count : count - (abs(n) % count)
        return Array(array[index..<count] + array[0..<index])
    }

    /// Returns the nth inversion of the given sorted array of semitone indices
    static func invert(semitoneIndices: [Float], n: UInt) -> [Float] {
        let count = semitoneIndices.count
        let modN = Int(n) % count
        var semitones = semitoneIndices
        for i in 0..<modN {
            let next = semitones[0] + 12
            semitones = Array(semitones[1..<count] + [next])
        }
        return semitones
    }

    /// Transforms an array of semitone indices so that the first index is zero
    static func zero(semitoneIndices: [Float]) -> [Float] {
        if semitoneIndices.count < 1 { return semitoneIndices }
        return semitoneIndices.map { return $0 - semitoneIndices.first! }
    }

    /// Converts an array of intervals to semitone indices
    /// e.g. [4, 3] -> [0, 4, 7]
    static func semitoneIndices(intervals: [Float]) -> [Float] {
        var indices : [Float] = [0]
        for i in 0..<intervals.count {
            let next = indices[i] + intervals[i]
            indices.append(next)
        }
        return indices
    }

    /// Converts an array of semitone indices to intervals
    /// e.g. [0, 4, 7] -> [4, 3]
    static func intervals(semitoneIndices: [Float]) -> [Float] {
        var intervals : [Float] = []
        for i in 1..<semitoneIndices.count {
            let delta = semitoneIndices[i] - semitoneIndices[i-1]
            intervals.append(delta)
        }
        return intervals
    }

    /// Returns the insertion point for `pitch` in the collection of `pitches`.
    ///
    /// If `pitch` exists at least once in `pitches`, the returned index will point to the
    /// first instance of `pitch`. Otherwise, it will point to the location where `pitch`
    /// could be inserted, keeping `pitchSet` in order.
    ///
    /// :returns: An index in the range `0...count(pitches)` where `pitch` can be inserted.
    static func insertionIndex<C: CollectionType where
        C.Generator.Element == Pitch, C.Index == Int>(pitches: C,_ pitch: Pitch) -> Int
    {
        if isEmpty(pitches) {
            return 0
        }

        var (low, high) = (0, pitches.endIndex - 1)
        var mid = 0

        while low < high {
            mid = (high - low) / 2 + low
            if pitches[mid] < pitch {
                low = mid + 1
            } else {
                high = mid
            }
        }
        
        if pitches[low] >= pitch {
            return low
        }
        
        return pitches.endIndex
    }
}


