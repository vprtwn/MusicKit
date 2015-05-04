//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum Accidental : String {
    case DoubleFlat = "𝄫"
    case Flat = "♭"
    case Natural = "♮"
    case Sharp = "♯"
    case DoubleSharp = "𝄪"

    /// The number of semitones the accidental represents
    public func semitones() -> Int {
        switch self {
        case .DoubleFlat:
            return -2
        case .Flat:
            return -1
        case .Natural:
            return 0
        case .Sharp:
            return 1
        case .DoubleSharp:
            return 2
        }
    }
}
