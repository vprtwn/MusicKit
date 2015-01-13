//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Ordered set of Pitches
public struct PitchSet : CollectionType, Equatable, Printable {

    var pitches : [Pitch] = []
    var pitchToBool : [Pitch : Bool] = [:]
    public var startIndex : Int = 0
    public var endIndex : Int = 0

    public init() {

    }

    /// How many elements the PitchSet stores
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

    mutating func _add(pitch: Pitch) {
        pitchToBool[pitch] = true
        endIndex++
    }

    public mutating func add(pitch: Pitch) {
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
                _add(pitch)
            }
            else if pitch > pitches[0] {
                pitches.append(pitch)
                _add(pitch)
            }
        }
        else {
            if pitch < pitches.first {
                pitches.insert(pitch, atIndex: 0)
                _add(pitch)
                return
            }
            for i in 1..<pitches.count {
                let previousPitch = pitches[i-1]
                let currentPitch = pitches[i]
                if pitch > previousPitch && pitch < currentPitch {
                    pitches.insert(pitch, atIndex: i)
                    _add(pitch)
                    return
                }
            }
            let lastPitchOpt = pitches.last
            if let lastPitch = lastPitchOpt {
                if pitch > lastPitch {
                    pitches.append(pitch)
                    _add(pitch)
                }
            }
        }
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
        lhs.add(pitch)
    }
    return lhs
}

public func +=(inout lhs: PitchSet, rhs: PitchSet) -> PitchSet {
    for pitch in rhs {
        lhs.add(pitch)
    }
    return lhs
}



