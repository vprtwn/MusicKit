//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ScaleQuality : Printable {
    case Chromatic
    case Wholetone
    case Octatonic1
    case Octatonic2
    case Major
    case Dorian
    case Phrygian
    case Lydian
    case Mixolydian
    case Minor
    case Locrian

    public var description : String {
        switch self {
        case Chromatic: return "Chromatic"
        case Wholetone: return "Wholetone"
        case Octatonic1: return "Octatonic mode 1"
        case Octatonic2: return "Octatonic mode 2"
        case Major: return "Major"
        case Dorian: return "Dorian"
        case Phrygian: return "Phrygian"
        case Lydian: return "Lydian"
        case Mixolydian: return "Mixolydian"
        case Minor: return "Minor"
        case Locrian: return "Locrian"
        }
    }

    public var intervals : [Float] {
        switch self {
        case Chromatic: return [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        case Wholetone: return [2, 2, 2, 2, 2, 2]
        case Octatonic1: return [2, 1, 2, 1, 2, 1, 2]
        case Octatonic2: return [1, 2, 1, 2, 1, 2, 1]
        case Major: return [2, 2, 1, 2, 2, 2]
        case Dorian: return [2, 1, 2, 2, 2, 1]
        case Phrygian: return [1, 2, 2, 2, 1, 2]
        case Lydian: return [2, 2, 2, 1, 2, 2]
        case Mixolydian: return [2, 2, 1, 2, 2, 1]
        case Minor: return [2, 1, 2, 2, 1, 2]
        case Locrian: return [1, 2, 2, 1, 2, 2]
        }
    }
}
