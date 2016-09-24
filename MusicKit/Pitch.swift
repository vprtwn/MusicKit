//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// The auditory attribute of sound according to which sounds can be ordered 
/// on a scale from low to high (ANSI 1994)
public struct Pitch: Comparable {
    /// midi number to frequency
    /// TODO: move this to a temperament enum
    public static func mtof(_ midi: Float) -> Float {
        let exponent = Double((Float(midi) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    public let midi: Float

    /// Creates a `Pitch` with the given MIDI number.
    /// Note that non-integral MIDI numbers are allowed.
    public init(midi: Float) {
        self.midi = midi
    }

    /// Creates a `Pitch` with the given chroma (pitch class) and octave.
    public init(chroma: Chroma, octave: UInt) {
        self.midi = Float(chroma.rawValue + (octave+1)*12)
    }

    /// The frequency of the pitch in Hz
    public var frequency: Float {
        return Pitch.mtof(self.midi)
    }

    /// A `Chroma`, or nil if the pitch doesn't align with the chromas
    /// in the current tuning system.
    public var chroma: Chroma? {
        if self.midi - floor(self.midi) == 0 {
            return Chroma(rawValue: UInt(self.midi)%12)
        }
        return nil
    }

    var noteNameTuple: (LetterName, Accidental, Int)? {
        return chroma.flatMap {
            $0.names.first.map {
                noteNameWithOctave(octaveNumber, nameTuple: $0) } }
    }

    public var noteName: String? {
        return noteNameTuple.map {
            "\($0.0.description)\($0.1.description(true))\($0.2)"
        }
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
        return (noteName != nil) ? "\(noteName!)" : "\(frequency)Hz"
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
