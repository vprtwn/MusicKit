//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

// MARK: Gamut
extension PitchSet {
    /// Returns the set of chroma contained in the `PitchSet`
    public func gamut() -> Set<Chroma> {
        var set = Set<Chroma>()
        for pitch in self.contents {
            pitch.chroma.map { set.insert($0) }
        }
        return set
    }
}

// MARK: Transposable
extension PitchSet : Transposable {
    public func transpose(semitones: Float) -> PitchSet {
        return self
    }
}

// MARK: Harmonizer
extension PitchSet {
    /// Returns a harmonizer representation of this pitch set
    public func harmonizer() -> Harmonizer {
        return Harmony.IdentityHarmonizer
    }

    /// Returns a harmonizer representation of this pitch set,
    /// transposed by the given scale and degree
    public func harmonizer(scale: Harmonizer, degree: Float) -> Harmonizer {
        // TODO: implement
        return Harmony.IdentityHarmonizer
    }
}

// MARK: PitchSet-Pitch operators
public func +(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    lhs.insert(rhs)
    return lhs
}

public func +=(inout lhs: PitchSet, rhs: Pitch) {
    lhs.insert(rhs)
}

public func -(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    lhs.remove(rhs)
    return lhs
}

public func -=(inout lhs: PitchSet, rhs: Pitch) {
    lhs.remove(rhs)
}

// MARK: PitchSet/Chroma 
public func /(lhs: PitchSet, rhs: Chroma) -> PitchSet {
    if lhs.count == 0 {
        return lhs
    }
    var lhs = lhs
    let firstPitch = lhs[0]
    if firstPitch.chroma == nil {
        return lhs
    }
    var newFirstPitch = firstPitch
    while (newFirstPitch.chroma.map { $0 == rhs } != Optional(true)) {
        newFirstPitch = Pitch(midi: newFirstPitch.midi - 1)
    }
    lhs.insert(newFirstPitch)
    return lhs
}