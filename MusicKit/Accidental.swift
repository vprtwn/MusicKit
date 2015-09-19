//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum Accidental: Float, CustomStringConvertible {
    case DoubleFlat = -2
    case Flat = -1
    case Natural = 0
    case Sharp = 1
    case DoubleSharp = 2

    public func description(stripNatural: Bool) -> String {
        switch self {
        case .Natural:
            return stripNatural ? "" : description
        default:
            return description
        }
    }

    public var description: String {
        switch self {
        case .DoubleFlat:
            return "𝄫"
        case .Flat:
            return "♭"
        case .Natural:
            return "♮"
        case .Sharp:
            return "♯"
        case .DoubleSharp:
            return "𝄪"
        }
    }
}
