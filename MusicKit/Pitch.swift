//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// The auditory attribute of sound according to which sounds can be ordered 
/// on a scale from low to high (ANSI 1994)
public struct Pitch: Comparable {
    public let midi: Float

    /// Creates a `Pitch` with the given MIDI number.
    /// Note that non-integral MIDI numbers are allowed.
    public init(midi: Float) {
        self.midi = midi
    }
    
    /// Creates a `Pitch` with the given frequency in hz.
    /// Note that non-integral MIDI numbers might result.
    public init(frequency: Float) {
        self.midi = Float(MusicKit.temperament.ftom(Double(frequency)))
    }

    /// Creates a `Pitch` with the given chroma (pitch class) and octave.
    public init(chroma: Chroma, octave: UInt) {
        self.midi = Float(chroma.rawValue + (octave+1)*12)
    }

    /// The frequency of the pitch in Hz
    public var frequency: Float {
        return Float(MusicKit.temperament.mtof(Double(self.midi)))
    }

    /// A `Chroma` in the current tuning system.
    public var chroma: Chroma {
        return Chroma(rawValue: UInt(self.midi.rounded()) % 12)!
    }
    
    /// A value between -0.5 and 0.5 representing
    /// the current deviation (e.g. for midi 60.5
    /// deviation is 0.5)
    public var deviation: Float {
        let a = self.midi.truncatingRemainder(dividingBy: 1.0)
        return a >= 0.5 ? a - 1 : a
    }
    
    public var isAligned: Bool {
        return deviation == 0
    }

    public var noteName: (LetterName, Accidental, Int) {
        return noteNameWithOctave(octaveNumber, nameTuple: chroma.names.first!)
    }

    /// Unadjusted octave number
    var octaveNumber: Int {
        return Int((self.midi - 12.0)/12.0)
    }

    /// Combines an octave number with a chroma name, taking into account
    /// edge cases for enharmonics like B#
    func noteNameWithOctave(_ octave: Int, nameTuple name: ChromaNameTuple) -> (LetterName, Accidental, Int) {
        let cFlat: ChromaNameTuple = (.c, .flat)
        let bSharp: ChromaNameTuple = (.b, .sharp)
        var adjustedOctaveNumber = octave
        if name == cFlat {
            adjustedOctaveNumber += 1
        }
        else if name == bSharp {
            adjustedOctaveNumber -= 1
        }
        return (name.0, name.1, adjustedOctaveNumber)
    }
}

// MARK: Printable
extension Pitch: CustomStringConvertible {
    public var description: String {
        return "\(noteName.0.description)\(noteName.1.description(true))\(noteName.2)"
    }
}

// MARK: Hashable
extension Pitch: Hashable {
    public var hashValue: Int {
        return midi.hashValue
    }
}

// MARK: Transposable
extension Pitch: Transposable {
    public func transpose(_ semitones: Float) -> Pitch {
        return Pitch(midi: midi + semitones)
    }
}

// MARK: Operators
public func ==(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midi == rhs.midi
}

public func <(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midi < rhs.midi
}

public func +(lhs: Pitch, rhs: Float) -> Pitch {
    return Pitch(midi: lhs.midi + rhs)
}

public func -(lhs: Pitch, rhs: Float) -> Pitch {
    return lhs + (-rhs)
}

public func -(lhs: Pitch, rhs: Pitch) -> Float {
    return lhs.midi - rhs.midi
}

postfix func --(pitch: inout Pitch) -> Pitch {
    pitch = pitch - 1
    return pitch
}

postfix func ++(pitch: inout Pitch) -> Pitch {
    pitch = pitch + 1
    return pitch
}
