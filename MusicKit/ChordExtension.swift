//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ChordExtension: UInt, CustomStringConvertible {
    case flatNine = 13
    case nine = 14
    case eleven = 17
    case sharpEleven = 18
    case flatThirteen = 20
    case thirteen = 21

    public var description: String {
        switch self {
        case .flatNine: return "♭9"
        case .nine: return "9"
        case .eleven: return "11"
        case .sharpEleven: return "♯11"
        case .flatThirteen: return "♭13"
        case .thirteen: return "13"
        }
    }
}
