//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ScaleQuality: String {
    case Chromatic = "Chromatic"
    case Wholetone = "Wholetone"
    case Octatonic1 = "Octatonic mode 1"
    case Octatonic2 = "Octatonic mode 2"
    case Major = "Major"
    case Dorian = "Dorian"
    case Phrygian = "Phrygian"
    case Lydian = "Lydian"
    case Mixolydian = "Mixolydian"
    case Minor = "Minor"
    case Locrian = "Locrian"

    public var intervals: [Float] {
        switch self {
        case .Chromatic: return [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        case .Wholetone: return [2, 2, 2, 2, 2, 2]
        case .Octatonic1: return [2, 1, 2, 1, 2, 1, 2]
        case .Octatonic2: return [1, 2, 1, 2, 1, 2, 1]
        case .Major: return [2, 2, 1, 2, 2, 2]
        case .Dorian: return [2, 1, 2, 2, 2, 1]
        case .Phrygian: return [1, 2, 2, 2, 1, 2]
        case .Lydian: return [2, 2, 2, 1, 2, 2]
        case .Mixolydian: return [2, 2, 1, 2, 2, 1]
        case .Minor: return [2, 1, 2, 2, 1, 2]
        case .Locrian: return [1, 2, 2, 1, 2, 2]
        }
    }
}

extension ScaleQuality: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}
