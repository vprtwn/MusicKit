//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public typealias ChromaNameTuple = (LetterName, Accidental)

public enum Chroma : UInt {
    case C = 0
    case Cs = 1
    case D = 2
    case Ds = 3
    case E = 4
    case F = 5
    case Fs = 6
    case G = 7
    case Gs = 8
    case A = 9
    case As = 10
    case B = 11

    public var names : [ChromaNameTuple] {
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
    public func validateName(name: ChromaNameTuple) -> Bool {
        return self.names.reduce(false, combine: { (a, r) -> Bool in
            a || (r == name)
        })
    }
}

// MARK: Printable
extension Chroma : Printable {
    public var description : String {
        let nameTupleOpt : ChromaNameTuple? = self.names.first
        if let n = nameTupleOpt {
            let accidental = (n.1 != .Natural) ? n.1.rawValue : ""
            return "\(n.0.rawValue)\(accidental)"
        }
        return ""
    }
}

// MARK: Operators
public func == (p1:(LetterName, Accidental), p2:(LetterName, Accidental)) -> Bool
{
    return (p1.0 == p2.0) && (p1.1 == p2.1)
}

public func -(lhs: Chroma, rhs: Int) -> Chroma {
    var rhs = rhs
    while rhs < 0 {
        rhs = rhs + 12
    }
    return Chroma(rawValue: lhs.rawValue - UInt(rhs % 12))!
}

public func +(lhs: Chroma, rhs: Int) -> Chroma {
    var rhs = rhs
    while rhs < 0 {
        rhs = rhs + 12
    }
    return Chroma(rawValue: lhs.rawValue + UInt(rhs % 12))!
}

public func *(lhs: Chroma, rhs: Int) -> Pitch {
    return Pitch(chroma: lhs, octave: UInt(abs(rhs)))
}
