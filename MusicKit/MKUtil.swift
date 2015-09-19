//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum MKUtil {
    /// Returns the nth inversion of the given sorted array of semitone indices
    static func invert(semitoneIndices: [Float], n: UInt) -> [Float] {
        let count = semitoneIndices.count
        let modN = Int(n) % count
        var semitones = semitoneIndices
        for _ in 0..<modN {
            let next = semitones[0] + 12
            semitones = Array(semitones[1..<count] + [next])
        }
        return semitones
    }

    /// Transforms an array of semitone indices so that the first index is zero
    static func zero(semitoneIndices: [Float]) -> [Float] {
        if semitoneIndices.count < 1 { return semitoneIndices }
        return semitoneIndices.map { return $0 - semitoneIndices[0] }
    }

    /// Collapses an array of semitone indices to within an octave
    static func collapse(semitoneIndices: [Float]) -> [Float] {
        let count = semitoneIndices.count
        if count < 1 { return semitoneIndices }
        let first = semitoneIndices[0]
        var newIndices = [first]
        for i in 1..<count {
            var newIndex = semitoneIndices[i]
            while newIndex - first > 12 {
                newIndex -= 12
            }
            newIndices = newIndices + [newIndex]
        }
        return newIndices.sort()
    }

    /// Converts an array of intervals to semitone indices
    /// e.g. [4, 3] -> [0, 4, 7]
    public static func semitoneIndices(intervals: [Float]) -> [Float] {
        var indices: [Float] = [0]
        for i in 0..<intervals.count {
            let next = indices[i] + intervals[i]
            indices.append(next)
        }
        return indices
    }

    /// Converts an array of semitone indices to intervals
    /// e.g. [0, 4, 7] -> [4, 3]
    public static func intervals(semitoneIndices: [Float]) -> [Float] {
        var intervals: [Float] = []
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
        if pitches.isEmpty {
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


