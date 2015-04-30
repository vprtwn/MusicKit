//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// A collection of unique `Pitch` instances ordered by frequency.
public struct PitchSet : CollectionType, Equatable, Printable {

    var pitches : [Pitch] = []
    var pitchToBool : [Pitch : Bool] = [:]
    public var startIndex : Int = 0
    public var endIndex : Int = 0

    public init() {

    }

    public var count: UInt {
        return UInt(endIndex - startIndex) + 1
    }

    public func generate() -> GeneratorOf<Pitch> {
        var index = startIndex
        return GeneratorOf<Pitch> {
            if index <= self.endIndex {
                let pitch = self.pitches[index]
                index++
                return pitch
            }
            else {
                return nil
            }
        }
    }

    mutating func _insert(pitch: Pitch) {
        pitchToBool[pitch] = true
        endIndex++
    }

    public mutating func insert(pitch: Pitch) {
        if let containsPitch = pitchToBool[pitch] {
            return
        }

        let count = pitches.count
        if count == 0 {
            pitches.append(pitch)
            pitchToBool[pitch] = true
        }
        else if count == 1 {
            if pitch < pitches[0] {
                pitches.insert(pitch, atIndex: 0)
                _insert(pitch)
            }
            else if pitch > pitches[0] {
                pitches.append(pitch)
                _insert(pitch)
            }
        }
        else {
            if pitch < pitches.first {
                pitches.insert(pitch, atIndex: 0)
                _insert(pitch)
                return
            }
            for i in 1..<pitches.count {
                let previousPitch = pitches[i-1]
                let currentPitch = pitches[i]
                if pitch > previousPitch && pitch < currentPitch {
                    pitches.insert(pitch, atIndex: i)
                    _insert(pitch)
                    return
                }
            }
            let lastPitchOpt = pitches.last
            if let lastPitch = lastPitchOpt {
                if pitch > lastPitch {
                    pitches.append(pitch)
                    _insert(pitch)
                }
            }
        }
    }

    // TODO: implement remove

    /// Returns the set of pitch classes contained in the pitch set
    public func pitchClassSet() -> Set<PitchClass> {
        var set = Set<PitchClass>()
        for pitch in self.pitches {
            pitch.pitchClass.map { set.insert($0) }
        }
        return set
    }

    public subscript(i: Int) -> Pitch {
        return pitches[i]
    }

    public var description : String {
        return pitches.description
    }
}

public func ==(lhs: PitchSet, rhs: PitchSet) -> Bool {
    return lhs.pitches == rhs.pitches
}

public func +(lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    var lhs = lhs
    for pitch in rhs {
        lhs.insert(pitch)
    }
    return lhs
}

public func +=(inout lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    for pitch in rhs {
        lhs.insert(pitch)
    }
    return lhs
}



