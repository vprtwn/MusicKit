//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum IntervalQuality: UInt, CustomStringConvertible {
    case Unison = 0
    case MinorSecond = 1
    case MajorSecond = 2
    case MinorThird = 3
    case MajorThird = 4
    case PerfectFourth = 5
    case Tritone = 6
    case PerfectFifth = 7
    case MinorSixth = 8
    case MajorSixth = 9
    case MinorSeventh = 10
    case MajorSeventh = 11
    case Octave = 12
    case MinorNinth = 13
    case MajorNinth = 14
    case MinorTenth = 15
    case MajorTenth = 16
    case PerfectEleventh = 17
    case Tritave = 18
    case PerfectTwelfth = 19
    case MinorThirteenth = 20
    case MajorThirteenth = 21
    case MinorFourteenth = 22
    case MajorFourteenth = 23

    public var description: String {
        switch self {
        case Unison: return "unison"
        case MinorSecond: return "minor second"
        case MajorSecond: return "major second"
        case MinorThird: return "minor third"
        case MajorThird: return "major third"
        case PerfectFourth: return "perfect fourth"
        case Tritone: return "tritone"
        case PerfectFifth: return "perfect fifth"
        case MinorSixth: return "minor sixth"
        case MajorSixth: return "major sixth"
        case MinorSeventh: return "minor seventh"
        case MajorSeventh: return "major seventh"
        case Octave: return "octave"
        case MinorNinth: return "minor ninth"
        case MajorNinth: return "major ninth"
        case MinorTenth: return "minor tenth"
        case MajorTenth: return "major tenth"
        case PerfectEleventh: return "perfect eleventh"
        case Tritave: return "tritave"
        case PerfectTwelfth: return "perfect twelfth"
        case MinorThirteenth: return "minor thirteenth"
        case MajorThirteenth: return "major thirteenth"
        case MinorFourteenth: return "minor fourteenth"
        case MajorFourteenth: return "major fourteenth"
        }
    }

    public var shortName: String {
        switch self {
        case Unison: return "P1"
        case MinorSecond: return "m2"
        case MajorSecond: return "M2"
        case MinorThird: return "m3"
        case MajorThird: return "M3"
        case PerfectFourth: return "P4"
        case Tritone: return "A4"
        case PerfectFifth: return "P5"
        case MinorSixth: return "m6"
        case MajorSixth: return "M6"
        case MinorSeventh: return "m7"
        case MajorSeventh: return "M7"
        case Octave: return "P8"
        case MinorNinth: return "m9"
        case MajorNinth: return "M9"
        case MinorTenth: return "m10"
        case MajorTenth: return "M10"
        case PerfectEleventh: return "P11"
        case Tritave: return "A11"
        case PerfectTwelfth: return "P12"
        case MinorThirteenth: return "m13"
        case MajorThirteenth: return "M13"
        case MinorFourteenth: return "m14"
        case MajorFourteenth: return "M14"
        }
    }
}
