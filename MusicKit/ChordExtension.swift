//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ChordExtension: UInt, CustomStringConvertible {
    case FlatNine = 13
    case Nine = 14
    case Eleven = 17
    case SharpEleven = 18
    case FlatThirteen = 20
    case Thirteen = 21

    public var description: String {
        switch self {
        case FlatNine: return "9"
        case Nine: return "♭9"
        case Eleven: return "11"
        case SharpEleven: return "♯11"
        case FlatThirteen: return "♭13"
        case Thirteen: return "13"
        }
    }
}