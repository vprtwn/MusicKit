//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

// MARK: Gamut
extension PitchSet {
    /// Returns the set of chroma contained in the `PitchSet`
    public func gamut() -> Set<Chroma> {
        var set = Set<Chroma>()
        for pitch in self.contents {
            if let chroma = pitch.chroma {
                set.insert(chroma)
            }
        }
        return set
    }
}

// MARK: Transposable
extension PitchSet: Transposable {
    public func transpose(_ semitones: Float) -> PitchSet {
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
    public func harmonicFunction(_ scale: @escaping Harmonizer, _ degree: Float) -> Harmonizer {
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

    /// Inverts the `PitchSet` the given number of times. 
    /// A single inversion moves the bottom pitch to the top.
    public mutating func invert(_ n: UInt = 1) {
        for _ in 0..<n {
            _invert()
        }
    }

    mutating func _invert() {
        if self.count < 1 {
            return
        }
        var bass = self[0]
        _ =  remove(bass)
        let last = self[count - 1]
        while bass < last {
            bass = bass + 12
        }
        insert(bass)
    }

    /// Extends the pitch set by repeating for the given number of octaves
    public func extend(_ octaves: Int) -> PitchSet {
        var pitchSet = self
        if octaves == 0 { return pitchSet }
        let start = octaves < 0 ? -1 : 1
        for i in start...octaves {
            pitchSet.insert(transpose(Float(12*i)))
        }
        return pitchSet
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
        for pitch in pitchesToRemove {
            _ =  self.remove(pitch)
        }
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
                _ =  remove(pitch)
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

// MARK: PitchSet-Pitch operators
public func +(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    lhs.insert(rhs)
    return lhs
}

public func +=(lhs: inout PitchSet, rhs: Pitch) {
    lhs.insert(rhs)
}

public func -(lhs: PitchSet, rhs: Pitch) -> PitchSet {
    var lhs = lhs
    _ =  lhs.remove(rhs)
    return lhs
}

public func -=(lhs: inout PitchSet, rhs: Pitch) {
    _ =  lhs.remove(rhs)
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
        newFirstPitch = newFirstPitch--
    }
    lhs.insert(newFirstPitch)
    return lhs
}
