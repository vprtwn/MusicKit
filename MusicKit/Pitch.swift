//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// A type representing `Pitch`
public struct Pitch : Comparable {
    /// midi number to frequency
    /// TODO: move this to a temperament enum
    public static func mtof(midi: Float) -> Float {
        let exponent = Double((Float(midi) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    public let midi : Float

    /// The preferred chroma name. Default is nil.
    var _preferredName : ChromaNameTuple?
    public var preferredName : ChromaNameTuple? {
        get {
            return _preferredName
        }
        set(newName) {
            if let chroma = self.chroma {
                if let name = newName {
                    if chroma.validateName(name) {
                        _preferredName = name
                    }
                }
            }
        }
    }

    public init(midi: Float) {
        self.midi = midi
    }

    public init(chroma: Chroma, octave: UInt) {
        self.midi = Float(chroma.index + (octave+1)*12)
    }

    /// Frequency in Hz
    public var frequency : Float {
        return Pitch.mtof(self.midi)
    }

    /// A `Chroma`, or nil if the pitch doesn't align with the chromas
    /// in the current tuning system.
    public var chroma : Chroma? {
        if self.midi - floor(self.midi) == 0 {
            return Chroma(index: UInt(self.midi)%12)
        }
        return nil
    }

    public var noteNameTuple : (LetterName, Accidental, Int)? {
        if chroma == nil {
            return nil
        }
        else if let name = preferredName {
            return noteNameWithOctave(octaveNumber, nameTuple: name)
        }
        else if let name = chroma!.names.first {
            return noteNameWithOctave(octaveNumber, nameTuple: name)
        }
        else {
            return nil
        }
    }

    public var noteName : String {
        let nameTupleOpt : (LetterName, Accidental, Int)? = noteNameTuple

        if let nameTuple = nameTupleOpt {
            let accidentalString = stringForAccidental(nameTuple.1)
            return "\(nameTuple.0.rawValue)\(accidentalString)\(nameTuple.2)"
        }
        else {
            return ""
        }
    }

    /// Strips naturals for note names
    func stringForAccidental(a: Accidental) -> String {
        return a == .Natural ? "" : a.rawValue
    }

    /// Unadjusted octave number
    var octaveNumber : Int {
        return Int((self.midi - 12.0)/12.0)
    }

    /// Combines an octave number with a chroma name, taking into account
    /// edge cases for enharmonics like B#
    func noteNameWithOctave(octave: Int, nameTuple name: ChromaNameTuple) -> (LetterName, Accidental, Int) {
        let cFlat : ChromaNameTuple = (.C, .Flat)
        let bSharp : ChromaNameTuple = (.B, .Sharp)
        var adjustedOctaveNumber = octave
        if name == cFlat {
            adjustedOctaveNumber++
        }
        else if name == bSharp {
            adjustedOctaveNumber--
        }
        return (name.0, name.1, adjustedOctaveNumber)
    }
}

// MARK: Printable

extension Pitch : Printable {
    public var description : String {
        return (count(noteName) != 0) ? "\(noteName)" : "\(frequency)Hz"
    }
}

// MARK: Hashable

extension Pitch: Hashable {
    public var hashValue : Int {
        return midi.hashValue
    }
}

// MARK: Operators
public func ==(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midi == rhs.midi
}

public func <(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midi < rhs.midi
}
