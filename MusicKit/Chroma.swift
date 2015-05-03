//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct Chroma : Comparable {
    public let index : UInt
    public init(index: UInt) {
        self.index = index
    }

    public var names : [ChromaNameTuple] {
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
    public func validateName(name: ChromaNameTuple) -> Bool {
        return self.names.reduce(false, combine: { (a, r) -> Bool in
            a || (r == name)
        })
    }

    public static let C = Chroma(index: 0)
    public static let Cs = Chroma(index: 1)
    public static let D = Chroma(index: 2)
    public static let Ds = Chroma(index: 3)
    public static let E = Chroma(index: 4)
    public static let F = Chroma(index: 5)
    public static let Fs = Chroma(index: 6)
    public static let G = Chroma(index: 7)
    public static let Gs = Chroma(index: 8)
    public static let A = Chroma(index: 9)
    public static let As = Chroma(index: 10)
    public static let B = Chroma(index: 11)
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

// MARK: Hashable
extension Chroma : Hashable {
    public var hashValue : Int {
        return index.hashValue
    }
}

// MARK: Operators

public func ==(lhs: Chroma, rhs: Chroma) -> Bool {
    return lhs.index == rhs.index
}

public func <(lhs: Chroma, rhs: Chroma) -> Bool {
    return lhs.index < rhs.index
}

public func -(lhs: Chroma, rhs: UInt) -> Chroma {
    return Chroma(index: lhs.index - UInt(rhs % 12))
}

public func +(lhs: Chroma, rhs: UInt) -> Chroma {
    return Chroma(index: lhs.index + UInt(rhs % 12))
}
