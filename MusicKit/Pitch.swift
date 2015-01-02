//  Copyright (c) 2015 Ben Guo. All rights reserved.

public enum LetterName : String {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"
}

public enum Accidental : String {
    case Natural = "♮"
    case Sharp = "♯"
    case Flat = "♭"
    case DoubleSharp = "𝄪"
    case DoubleFlat = "𝄫"
}

public typealias PitchClassName = (LetterName, Accidental)
public func == (p1:(LetterName, Accidental), p2:(LetterName, Accidental)) -> Bool
{
    return (p1.0 == p2.0) && (p1.1 == p2.1)
}

public struct PitchClass : Printable {
    public let index : UInt
    public init(index: UInt) {
        self.index = index
    }

    public var names : [PitchClassName] {
        switch self.index {
        case 0:
            return [(.C, .Natural), (.B, .Sharp)]
        case 1:
            return [(.D, .Flat), (.C, .Sharp)]
        case 2:
            return [(.D, .Natural)]
        case 3:
            return [(.E, .Flat), (.D, .Sharp)]
        case 4:
            return [(.E, .Natural)]
        case 5:
            return [(.F, .Natural), (.E, .Sharp)]
        case 6:
            return [(.F, .Sharp), (.G, .Flat)]
        case 7:
            return [(.G, .Natural)]
        case 8:
            return [(.A, .Flat), (.G, .Sharp)]
        case 9:
            return [(.A, .Natural)]
        case 10:
            return [(.B, .Flat), (.A, .Sharp)]
        case 11:
            return [(.B, .Natural), (.C, .Flat)]
        default:
            return []
        }
    }

    public var description : String {
        if let first = self.names.first {
            let letter = first.0.rawValue
            let accidental = first.1.rawValue
            return "\(letter)\(accidental)"
        }
        else {
            return ""
        }

    }
}

public struct Pitch : Printable {
    // midi number to frequency
    public static func mtof(midiNumber: Float) -> Float {
        let exponent = Double((Float(midiNumber) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    // frequency to midi number
    public static func ftom(frequency: Float) -> Float {
        let octaves = log2(Double(frequency) / MusicKit.concertA)
        return Float(69.0 + (12.0*octaves))
    }

    public let midiNumber : Float

    public var preferredPitchClassName : PitchClassName?

    public init(midiNumber: Float) {
        self.midiNumber = midiNumber
    }

    public init(frequency: Float) {
        self.midiNumber = Pitch.ftom(frequency)
    }

    public var frequency : Float {
        return Pitch.mtof(self.midiNumber)
    }

    public var pitchClass : PitchClass? {
        if self.midiNumber - floor(self.midiNumber) == 0 {
            return PitchClass(index: UInt(self.midiNumber)%12)
        }
        return nil
    }

    public var octaveNumber : Int {
        return Int((self.midiNumber - 12.0)/12.0)
    }

    public var noteNameTuple : (LetterName, Accidental, Int)? {
        if pitchClass == nil {
            return nil
        }
        else if let name = preferredPitchClassName {
            return applyOctaveNumber(octaveNumber, toPitchClassName: name)
        }
        else if let name = pitchClass!.names.first {
            return applyOctaveNumber(octaveNumber, toPitchClassName: name)
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

    // Strip naturals for note names
    func stringForAccidental(a: Accidental) -> String {
        return a == .Natural ? "" : a.rawValue
    }

    // Apply an octave number to a pitch class name, taking into account
    // edge cases for enharmonics like B#
    func applyOctaveNumber(octaveNumber: Int, toPitchClassName name: PitchClassName)
        -> (LetterName, Accidental, Int) {
            let cFlat : PitchClassName = (.C, .Flat)
            let bSharp : PitchClassName = (.B, .Sharp)
            var adjustedOctaveNumber = octaveNumber
            if name == cFlat {
                adjustedOctaveNumber++
            }
            else if name == bSharp {
                adjustedOctaveNumber--
            }
            return (name.0, name.1, adjustedOctaveNumber)
    }

    public var description : String {
        return "\(noteName): \(frequency)Hz"
    }
}