//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum LetterName : String {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"

    static let letters : [LetterName] = [.C, .D, .E, .F, .G, .A, .B]
    public func next() -> LetterName {
        let index : Int = find(LetterName.letters, self)!
        let newIndex = (index + 1) % LetterName.letters.count
        return LetterName.letters[newIndex]
    }

    public func previous() -> LetterName {
        let index : Int = find(LetterName.letters, self)!
        let count = LetterName.letters.count
        let newIndex = (((index - 1)%count) + count)%count
        return LetterName.letters[newIndex]
    }
}

public enum Accidental : String {
    case DoubleFlat = "𝄫"
    case Flat = "♭"
    case Natural = "♮"
    case Sharp = "♯"
    case DoubleSharp = "𝄪"
}

public typealias PitchClassNameTuple = (LetterName, Accidental)
public func == (p1:(LetterName, Accidental), p2:(LetterName, Accidental)) -> Bool
{
    return (p1.0 == p2.0) && (p1.1 == p2.1)
}

// MARK: PitchClass
public struct PitchClass : Printable, Comparable {
    public let index : UInt
    public init(index: UInt) {
        self.index = index
    }

    public var names : [PitchClassNameTuple] {
        switch self.index {
        case 0:
            return [(.C, .Natural), (.B, .Sharp), (.D, .DoubleFlat)]
        case 1:
            return [(.C, .Sharp), (.D, .Flat), (.B, .DoubleSharp)]
        case 2:
            return [(.D, .Natural), (.C, .DoubleSharp), (.E, .DoubleFlat)]
        case 3:
            return [(.E, .Flat), (.D, .Sharp), (.F, .DoubleFlat)]
        case 4:
            return [(.E, .Natural), (.F, .Flat), (.D, .DoubleSharp)]
        case 5:
            return [(.F, .Natural), (.E, .Sharp), (.G, .DoubleFlat)]
        case 6:
            return [(.F, .Sharp), (.G, .Flat), (.E, .DoubleSharp)]
        case 7:
            return [(.G, .Natural), (.F, .DoubleSharp), (.A, .DoubleFlat)]
        case 8:
            return [(.A, .Flat), (.G, .Sharp)]
        case 9:
            return [(.A, .Natural), (.G, .DoubleSharp), (.B, .DoubleFlat)]
        case 10:
            return [(.B, .Flat), (.A, .Sharp), (.C, .DoubleFlat)]
        case 11:
            return [(.B, .Natural), (.C, .Flat), (.A, .DoubleSharp)]
        default:
            return []
        }
    }

    public func hasName(name: PitchClassNameTuple) -> Bool {
        return self.names.reduce(false, combine: { (a, r) -> Bool in
            a || (r == name)
        })
    }

    public var description : String {
        let n : PitchClassNameTuple? = self.names.first
        let stringOpt = n.map { "\($0.0.rawValue)\($0.1.rawValue)" }
        if stringOpt == nil {
            return ""
        }
        return stringOpt!
    }
}

public func ==(lhs: PitchClass, rhs: PitchClass) -> Bool {
    return lhs.index == rhs.index
}

public func <(lhs: PitchClass, rhs: PitchClass) -> Bool {
    return lhs.index < rhs.index
}

// MARK: Pitch
public struct Pitch : Printable, Comparable, Hashable {
    /// midi number to frequency
    /// TODO: move this to an equal temperament constant
    public static func mtof(midiNumber: Float) -> Float {
        let exponent = Double((Float(midiNumber) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    public let midiNumber : Float

    /// The preferred pitch class name.
    /// Can only be set to a valid name. Default is nil.
    var _preferredName : PitchClassNameTuple?
    public var preferredName : PitchClassNameTuple? {
        get {
            return _preferredName
        }
        set(newName) {
            if newName == nil {
                return
            }
            if let pitchClass = self.pitchClass {
                if pitchClass.hasName(newName!) {
                    _preferredName = newName
                }
            }
        }
    }

    public init(midiNumber: Float) {
        self.midiNumber = midiNumber
    }

    /// Frequency in Hz
    public var frequency : Float {
        return Pitch.mtof(self.midiNumber)
    }

    /// A PitchClass, or nil if the pitch doesn't align with the pitch classes
    /// in the current tuning system.
    public var pitchClass : PitchClass? {
        if self.midiNumber - floor(self.midiNumber) == 0 {
            return PitchClass(index: UInt(self.midiNumber)%12)
        }
        return nil
    }

    public var noteNameTuple : (LetterName, Accidental, Int)? {
        if pitchClass == nil {
            return nil
        }
        else if let name = preferredName {
            return noteNameWithOctave(octaveNumber, pitchClassName: name)
        }
        else if let name = pitchClass!.names.first {
            return noteNameWithOctave(octaveNumber, pitchClassName: name)
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

    // Strips naturals for note names
    func stringForAccidental(a: Accidental) -> String {
        return a == .Natural ? "" : a.rawValue
    }

    // Unadjusted octave number
    var octaveNumber : Int {
        return Int((self.midiNumber - 12.0)/12.0)
    }

    // Combines an octave number with a pitch class name, taking into account
    // edge cases for enharmonics like B#
    func noteNameWithOctave(octave: Int, pitchClassName name: PitchClassNameTuple) -> (LetterName, Accidental, Int) {
        let cFlat : PitchClassNameTuple = (.C, .Flat)
        let bSharp : PitchClassNameTuple = (.B, .Sharp)
        var adjustedOctaveNumber = octave
        if name == cFlat {
            adjustedOctaveNumber++
        }
        else if name == bSharp {
            adjustedOctaveNumber--
        }
        return (name.0, name.1, adjustedOctaveNumber)
    }

    public var description : String {
        return (noteName.utf16Count != 0) ? "\(noteName)" : "\(frequency)Hz"
    }

    public var hashValue : Int {
        return midiNumber.hashValue
    }

}

public func ==(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midiNumber == rhs.midiNumber
}

public func <(lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.midiNumber < rhs.midiNumber
}
