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
        // TODO: use PitchSet.map
        return PitchSet(contents.map { $0.transpose(semitones) })
    }
}

// MARK: Harmonizer
extension PitchSet {
    /// Returns a `Harmonizer` representation of this pitch set.
    public func harmonizer() -> Harmonizer {
        return Harmony.create(MKUtil.intervals(semitoneIndices()))
    }

    /// Returns the harmonic function of this pitch set (as a `Harmonizer`),
    /// in the given scale and degree.
    public func harmonicFunction(scale: Harmonizer, _ degree: Float) -> Harmonizer {
        return HarmonicFunction.create(scale, degree: degree, chord: harmonizer())
    }
}

// MARK: Misc
extension PitchSet {
    /// Returns the semitone indices when the lowest pitch is given index 0.
    public func semitoneIndices() -> [Float] {
        if self.count < 1 {
            return [Float(0)]
        }
        let first = self[0].midi
        return map { $0.midi - first }
    }

    /// Extends the pitch set by repeating with octave displacement.
    public mutating func extendOctaves(octaves: Int) {
        if octaves == 0 { return }
        let start = octaves < 0 ? -1 : 1
        for i in start...octaves {
            insert(transpose(Float(12*i)))
        }
    }

    /// Removes duplicate chroma from the pitch set, starting from the root.
    /// Note that pitches without chroma will be ignored.
    public mutating func dedupe() {
        var gamut = Set<Chroma>()
        var pitchesToRemove = PitchSet()
        for i in 0..<count {
            let p = self[i]
            if let chroma = p.chroma {
                if gamut.contains(chroma) {
                    pitchesToRemove.insert(p)
                }
                else {
                    gamut.insert(chroma)
                }
            }
        }
        pitchesToRemove.map { self.remove($0) }
    }

    /// Collapses the pitch set to within an octave, maintaining the bass.
    public mutating func collapse() {
        if count < 2 {
            return
        }
        let first = self[0]
        for i in 1..<count {
            var pitch = self[i]
            if pitch - first > 12 {
                remove(pitch)
                while pitch - first > 12 {
                    pitch = pitch.transpose(-12)
                }
                insert(pitch)
            }
        }
    }

    /// The first pitch, or `nil` if the set is empty.
    public func first() -> Pitch? {
        return contents.first
    }

    /// The last pitch, or `nil` if the set is empty
    public func last() -> Pitch? {
        return contents.last
    }
}

// MARK: Higher-order functions
extension PitchSet {
    public func map<T>(transform: Pitch -> T) -> [T] {
        return Swift.map(self, transform)
    }

    public func reduce<T>(initial: T, combine: (T, Pitch) -> T) -> T {
        return Swift.reduce(self, initial, combine)
    }

    public func filter(includeElement: Pitch -> Bool) -> PitchSet {
        return PitchSet(Swift.filter(self, includeElement))
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
        newFirstPitch--
    }
    lhs.insert(newFirstPitch)
    return lhs
}