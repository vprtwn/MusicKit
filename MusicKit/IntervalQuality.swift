//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum IntervalQuality: UInt, CustomStringConvertible {
    case unison = 0
    case minorSecond = 1
    case majorSecond = 2
    case minorThird = 3
    case majorThird = 4
    case perfectFourth = 5
    case tritone = 6
    case perfectFifth = 7
    case minorSixth = 8
    case majorSixth = 9
    case minorSeventh = 10
    case majorSeventh = 11
    case octave = 12
    case minorNinth = 13
    case majorNinth = 14
    case minorTenth = 15
    case majorTenth = 16
    case perfectEleventh = 17
    case tritave = 18
    case perfectTwelfth = 19
    case minorThirteenth = 20
    case majorThirteenth = 21
    case minorFourteenth = 22
    case majorFourteenth = 23

    public var description: String {
        switch self {
        case .unison: return "unison"
        case .minorSecond: return "minor second"
        case .majorSecond: return "major second"
        case .minorThird: return "minor third"
        case .majorThird: return "major third"
        case .perfectFourth: return "perfect fourth"
        case .tritone: return "tritone"
        case .perfectFifth: return "perfect fifth"
        case .minorSixth: return "minor sixth"
        case .majorSixth: return "major sixth"
        case .minorSeventh: return "minor seventh"
        case .majorSeventh: return "major seventh"
        case .octave: return "octave"
        case .minorNinth: return "minor ninth"
        case .majorNinth: return "major ninth"
        case .minorTenth: return "minor tenth"
        case .majorTenth: return "major tenth"
        case .perfectEleventh: return "perfect eleventh"
        case .tritave: return "tritave"
        case .perfectTwelfth: return "perfect twelfth"
        case .minorThirteenth: return "minor thirteenth"
        case .majorThirteenth: return "major thirteenth"
        case .minorFourteenth: return "minor fourteenth"
        case .majorFourteenth: return "major fourteenth"
        }
    }

    public var shortName: String {
        switch self {
        case .unison: return "P1"
        case .minorSecond: return "m2"
        case .majorSecond: return "M2"
        case .minorThird: return "m3"
        case .majorThird: return "M3"
        case .perfectFourth: return "P4"
        case .tritone: return "A4"
        case .perfectFifth: return "P5"
        case .minorSixth: return "m6"
        case .majorSixth: return "M6"
        case .minorSeventh: return "m7"
        case .majorSeventh: return "M7"
        case .octave: return "P8"
        case .minorNinth: return "m9"
        case .majorNinth: return "M9"
        case .minorTenth: return "m10"
        case .majorTenth: return "M10"
        case .perfectEleventh: return "P11"
        case .tritave: return "A11"
        case .perfectTwelfth: return "P12"
        case .minorThirteenth: return "m13"
        case .majorThirteenth: return "M13"
        case .minorFourteenth: return "m14"
        case .majorFourteenth: return "M14"
        }
    }
}
