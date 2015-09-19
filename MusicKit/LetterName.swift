//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum LetterName: UInt, CustomStringConvertible {
    case C = 0
    case D = 1
    case E = 2
    case F = 3
    case G = 4
    case A = 5
    case B = 6

    static let names: [String] = ["C", "D", "E", "F", "G", "A", "B"]
    public var description: String {
        return LetterName.names[Int(rawValue)]
    }
}

public func +(lhs: LetterName, rhs: Int) -> LetterName {
    var rhs = rhs
    while rhs < 0 {
        rhs += 7
    }
    let newRawValue = (lhs.rawValue + UInt(rhs))%7
    return LetterName(rawValue: newRawValue)!
}

public func -(lhs: LetterName, rhs: Int) -> LetterName {
    return lhs + (-1*rhs)
}
