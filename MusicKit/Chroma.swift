//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

typealias ChromaNameTuple = (LetterName, Accidental)

/// Pitch quality; also known as pitch class.
public enum Chroma: UInt {
    /// C
    case C = 0
    /// C Sharp
    case Cs = 1
    /// D
    case D = 2
    /// D Sharp
    case Ds = 3
    /// E
    case E = 4
    /// F
    case F = 5
    /// F Sharp
    case Fs = 6
    /// G
    case G = 7
    /// G Sharp
    case Gs = 8
    /// A
    case A = 9
    /// A Sharp
    case As = 10
    /// B
    case B = 11

    var names: [ChromaNameTuple] {
        switch self.rawValue {
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

    /// Returns true if the given name tuple is a valid name
    func validateName(name: ChromaNameTuple) -> Bool {
        return self.names.reduce(false, combine: { (a, r) -> Bool in
            a || (r == name)
        })
    }
}

// MARK: Printable
extension Chroma: CustomStringConvertible {
    public var description: String {
        let nameTupleOpt: ChromaNameTuple? = self.names.first
        if let (letterName, accidental) = nameTupleOpt {
            return "\(letterName.description)\(accidental.description(true))"
        }
        return ""
    }
}

// MARK: Operators
public func == (p1:(LetterName, Accidental), p2:(LetterName, Accidental)) -> Bool
{
    return (p1.0 == p2.0) && (p1.1 == p2.1)
}

public func +(lhs: Chroma, rhs: Int) -> Chroma {
    var rhs = rhs
    while rhs < 0 {
        rhs = rhs + 12
    }
    let newRawValue = (lhs.rawValue + UInt(rhs))%12
    return Chroma(rawValue: newRawValue)!
}

public func -(lhs: Chroma, rhs: Int) -> Chroma {
    return lhs + (-1*rhs)
}

postfix func --(inout chroma: Chroma) -> Chroma {
    chroma = chroma - 1
    return chroma
}

postfix func ++(inout chroma: Chroma) -> Chroma {
    chroma = chroma + 1
    return chroma
}

/// Returns the minimum distance between two chromas
public func -(lhs: Chroma, rhs: Chroma) -> UInt {
    let lminusr = abs(Int(lhs.rawValue) - Int(rhs.rawValue))
    let rminusl = abs(Int(rhs.rawValue) - Int(lhs.rawValue))
    return UInt(min(lminusr, rminusl))
}

public func *(lhs: Chroma, rhs: Int) -> Pitch {
    return Pitch(chroma: lhs, octave: UInt(abs(rhs)))
}
