//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct PitchClass : Comparable {
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
}

// MARK: Printable
extension PitchClass : Printable {
    public var description : String {
        let nameTupleOpt : PitchClassNameTuple? = self.names.first
        if let n = nameTupleOpt {
            let accidental = (n.1 != .Natural) ? n.1.rawValue : ""
            return "\(n.0.rawValue)\(accidental)"
        }
        return ""
    }
}

// MARK: Hashable
extension PitchClass : Hashable {
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
