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

public struct PitchClass : Printable, Comparable, Hashable {
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

    /// Returns true if the given name tuple is a valid name
    public func validateName(name: PitchClassNameTuple) -> Bool {
        return self.names.reduce(false, combine: { (a, r) -> Bool in
            a || (r == name)
        })
    }

    public static let C = PitchClass(index: 0)
    public static let Cs = PitchClass(index: 1)
    public static let D = PitchClass(index: 2)
    public static let Ds = PitchClass(index: 3)
    public static let E = PitchClass(index: 4)
    public static let F = PitchClass(index: 5)
    public static let Fs = PitchClass(index: 6)
    public static let G = PitchClass(index: 7)
    public static let Gs = PitchClass(index: 8)
    public static let A = PitchClass(index: 9)
    public static let As = PitchClass(index: 10)
    public static let B = PitchClass(index: 11)

    public var description : String {
        let nameTupleOpt : PitchClassNameTuple? = self.names.first
        if let n = nameTupleOpt {
            let accidental = (n.1 != .Natural) ? n.1.rawValue : ""
            return "\(n.0.rawValue)\(accidental)"
        }
        return ""
    }

    public var hashValue : Int {
        return index.hashValue
    }
}

// MARK: Operators

public func ==(lhs: PitchClass, rhs: PitchClass) -> Bool {
    return lhs.index == rhs.index
}

public func <(lhs: PitchClass, rhs: PitchClass) -> Bool {
    return lhs.index < rhs.index
}

public func -(lhs: PitchClass, rhs: UInt) -> PitchClass {
    return PitchClass(index: lhs.index - UInt(rhs % 12))
}

public func +(lhs: PitchClass, rhs: UInt) -> PitchClass {
    return PitchClass(index: lhs.index + UInt(rhs % 12))
}
