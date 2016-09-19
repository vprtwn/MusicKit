//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum Accidental: Float, CustomStringConvertible {
    case doubleFlat = -2
    case flat = -1
    case natural = 0
    case sharp = 1
    case doubleSharp = 2

    public func description(_ stripNatural: Bool) -> String {
        switch self {
        case .natural:
            return stripNatural ? "" : description
        default:
            return description
        }
    }

    public var description: String {
        switch self {
        case .doubleFlat:
            return "𝄫"
        case .flat:
            return "♭"
        case .natural:
            return "♮"
        case .sharp:
            return "♯"
        case .doubleSharp:
            return "𝄪"
        }
    }
}
