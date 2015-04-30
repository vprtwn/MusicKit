//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

extension Array {
    func rotate(n: Int) -> [T] {
        let count = self.count
        let index = (n >= 0) ? n % count : count - (abs(n) % count)
        return Array(self[index..<count] + self[0..<index])
    }
}

public struct MusicKit {
    public static var concertA : Double = 440.0

    public static let IdentityHarmonizer : Harmonizer = { pitch in
        var s = PitchSet()
        s.insert(pitch)
        return s
    }
}

public typealias Harmonizer = (Pitch -> PitchSet)

public func *(lhs: [Harmonizer], rhs: Pitch) -> [PitchSet] {
    return lhs.map { $0(rhs) }
}

public func *(lhs: Pitch, rhs: [Harmonizer]) -> [PitchSet] {
    return rhs.map { $0(lhs) }
}

public func *(lhs: Harmonizer, rhs: Pitch) -> PitchSet { return lhs(rhs) }

public func *(lhs: Pitch, rhs: Harmonizer) -> PitchSet { return rhs(lhs) }



