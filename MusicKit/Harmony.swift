//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct Harmony {
    /// The identity Harmonizer function
    public static let IdentityHarmonizer: Harmonizer = { pitch in
        return PitchSet(pitches: pitch)
    }

    /// Transposes a Harmonizer
    public static func transpose(_ f: @escaping Harmonizer, semitones: Float) -> Harmonizer {
        return { pitch in f(pitch.transpose(semitones)) }
    }

    /// Creates a Harmonizer using the given intervals
    public static func create(_ intervals: [Float]) -> Harmonizer {
        return { firstPitch in
            let pitchSet = PitchSet(pitches: firstPitch)
            return intervals.reduce(pitchSet) {
                (ps, interval) -> PitchSet in
                return ps + [ps.last()! + interval]
            }
        }
    }
}

// MARK: Type Aliases
public typealias Harmonizer = ((Pitch) -> PitchSet)

// MARK: Operators
public func *(lhs: Harmonizer, rhs: Pitch) -> PitchSet { return lhs(rhs) }

public func *(lhs: Pitch, rhs: Harmonizer) -> PitchSet { return rhs(lhs) }

public func *(lhs: [Harmonizer], rhs: Pitch) -> [PitchSet] {
    return lhs.map { $0(rhs) }
}

public func *(lhs: Pitch, rhs: [Harmonizer]) -> [PitchSet] {
    return rhs.map { $0(lhs) }
}
