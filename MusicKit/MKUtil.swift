//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum MKUtil {
    /// Rotates the array `n` times to the right
    public static func rotate<T>(array: [T],_ n: Int) -> [T] {
        let count = array.count
        let index = (n >= 0) ? n % count : count - (abs(n) % count)
        return Array(array[index..<count] + array[0..<index])
    }

    /// Returns the insertion point for `pitch` in the collection of `pitches`.
    ///
    /// If `pitch` exists at least once in `pitches`, the returned index will point to the
    /// first instance of `pitch`. Otherwise, it will point to the location where `pitch`
    /// could be inserted, keeping `pitchSet` in order.
    ///
    /// :returns: An index in the range `0...count(pitches)` where `pitch` can be inserted.
    //func _insertionIndex(pitches: [Pitch], pitch: Pitch) -> Int
    public static func insertionIndex<C: CollectionType where
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


