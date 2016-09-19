//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

typealias ChromaNameTuple = (LetterName, Accidental)

/// Pitch quality; also known as pitch class.
public enum Chroma: UInt {
    /// C
    case c = 0
    /// C Sharp
    case cs = 1
    /// D
    case d = 2
    /// D Sharp
    case ds = 3
    /// E
    case e = 4
    /// F
    case f = 5
    /// F Sharp
    case fs = 6
    /// G
    case g = 7
    /// G Sharp
    case gs = 8
    /// A
    case a = 9
    /// A Sharp
    case `as` = 10
    /// B
    case b = 11

    var names: [ChromaNameTuple] {
        switch self.rawValue {
        case 0:
            return [(.c, .natural), (.b, .sharp), (.d, .doubleFlat)]
        case 1:
            return [(.c, .sharp), (.d, .flat), (.b, .doubleSharp)]
        case 2:
            return [(.d, .natural), (.c, .doubleSharp), (.e, .doubleFlat)]
        case 3:
            return [(.e, .flat), (.d, .sharp), (.f, .doubleFlat)]
        case 4:
            return [(.e, .natural), (.f, .flat), (.d, .doubleSharp)]
        case 5:
            return [(.f, .natural), (.e, .sharp), (.g, .doubleFlat)]
        case 6:
            return [(.f, .sharp), (.g, .flat), (.e, .doubleSharp)]
        case 7:
            return [(.g, .natural), (.f, .doubleSharp), (.a, .doubleFlat)]
        case 8:
            return [(.a, .flat), (.g, .sharp)]
        case 9:
            return [(.a, .natural), (.g, .doubleSharp), (.b, .doubleFlat)]
        case 10:
            return [(.b, .flat), (.a, .sharp), (.c, .doubleFlat)]
        case 11:
            return [(.b, .natural), (.c, .flat), (.a, .doubleSharp)]
        default:
            return []
        }
    }

    /// Returns true if the given name tuple is a valid name
    func validateName(_ name: ChromaNameTuple) -> Bool {
        return self.names.reduce(false) {
          (a, r) -> Bool in
            a || (r == name)
        }
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

postfix func --(chroma: inout Chroma) -> Chroma {
    chroma = chroma - 1
    return chroma
}

postfix func ++(chroma: inout Chroma) -> Chroma {
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
