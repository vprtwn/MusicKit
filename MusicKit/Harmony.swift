//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct Harmony {
    /// The identity Harmonizer function
    public static let IdentityHarmonizer : Harmonizer = { pitch in
        var s = PitchSet()
        s.insert(pitch)
        return s
    }

    /// Transposes a Harmonizer
    static func transpose(f: Harmonizer, semitones: Float) -> Harmonizer {
        return { pitch in f(pitch.transpose(semitones)) }
    }
}

// MARK: Type Aliases
public typealias Harmonizer = (Pitch -> PitchSet)

// MARK: Operators
public func *(lhs: Harmonizer, rhs: Pitch) -> PitchSet { return lhs(rhs) }

public func *(lhs: Pitch, rhs: Harmonizer) -> PitchSet { return rhs(lhs) }

public func *(lhs: [Harmonizer], rhs: Pitch) -> [PitchSet] {
    return lhs.map { $0(rhs) }
}

public func *(lhs: Pitch, rhs: [Harmonizer]) -> [PitchSet] {
    return rhs.map { $0(lhs) }
}