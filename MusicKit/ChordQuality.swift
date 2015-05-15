//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ChordQuality : Printable {
    // triads
    case Major
    case Minor
    case Augmented
    case Diminished
    case Sus2
    case Sus4
    // tetrads
    case DominantSeventh
    case MajorSeventh
    case MinorMajorSeventh
    case MinorSeventh
    case AugmentedMajorSeventh
    case AugmentedSeventh
    case HalfDiminishedSeventh
    case DiminishedSeventh
    case DominantSeventhFlatFive
    case MajorSeventhFlatFive
    case DominantSeventhSusFour
    case MajorSeventhSusFour
    case MajorSixth
    case MinorSixth
    case AddNine
    case MinorAddNine
    // pentads
    case DominantNinth
    case DominantMinorNinth
    case MajorNinth
    case SixNine

    public var description : String {
        switch self {
        // triads
        case Major: return "major triad"
        case Minor: return "minor triad"
        case Augmented: return "augmented triad"
        case Diminished: return "diminished triad"
        case Sus2: return "suspended second"
        case Sus4: return "suspended fourth"
        // tetrads
        case DominantSeventh: return "dominant seventh"
        case MajorSeventh: return "major seventh"
        case MinorMajorSeventh: return "minor-major seventh"
        case MinorSeventh: return "minor seventh"
        case AugmentedMajorSeventh: return "augmented-major seventh"
        case AugmentedSeventh: return "augmented seventh"
        case HalfDiminishedSeventh: return "half-diminished seventh"
        case DiminishedSeventh: return "diminished seventh"
        case DominantSeventhFlatFive: return "dominant seventh flat five"
        case MajorSeventhFlatFive: return "major seventh flat five"
        case DominantSeventhSusFour: return "dominant seventh sus four"
        case MajorSeventhSusFour: return "major seventh sus four"
        case MajorSixth: return "major sixth"
        case MinorSixth: return "minor sixth"
        case AddNine: return "add nine"
        case MinorAddNine: return "minor add nine"
        case SixNine: return "six nine"
        // pentads
        case DominantNinth: return "dominant ninth"
        case DominantMinorNinth: return "dominant minor ninth"
        case MajorNinth: return "major ninth"
        }
    }

    public var symbol: String {
        switch self {
        // triads
        case Major: return "M"
        case Minor: return "m"
        case Augmented: return "+"
        case Diminished: return "°"
        case Sus2: return "sus2"
        case Sus4: return "sus4"
        // tetrads
        case DominantSeventh: return "7"
        case MajorSeventh: return "Δ7"
        case MinorMajorSeventh: return "mΔ7"
        case MinorSeventh: return "m7"
        case AugmentedMajorSeventh: return "+Δ7"
        case AugmentedSeventh: return "+7"
        case HalfDiminishedSeventh: return "ø7"
        case DiminishedSeventh: return "°7"
        case DominantSeventhFlatFive: return "7♭5"
        case MajorSeventhFlatFive: return "Δ7♭5"
        case DominantSeventhSusFour: return "7sus4"
        case MajorSeventhSusFour: return "Δ7sus4"
        case MajorSixth: return "6"
        case MinorSixth: return "m6"
        case AddNine: return "add9"
        case MinorAddNine: return "madd9"
        // pentads
        case DominantNinth: return "9"
        case DominantMinorNinth: return "7♭9"
        case MajorNinth: return "Δ9"
        case SixNine: return "6/9"
        }
    }

    public var intervals: [Float] {
        switch self {
        // triads
        case Major: return [4, 3]
        case Minor: return [3, 4]
        case Augmented: return [4, 4]
        case Diminished: return [3, 3]
        case Sus2: return [2, 5]
        case Sus4: return [5, 2]
        // tetrads
        case DominantSeventh: return [4, 3, 3]
        case MajorSeventh: return [4, 3, 4]
        case MinorMajorSeventh: return [3, 4, 4]
        case MinorSeventh: return [3, 4, 3]
        case AugmentedMajorSeventh: return [4, 4, 3]
        case AugmentedSeventh: return [4, 4, 2]
        case HalfDiminishedSeventh: return [3, 3, 4]
        case DiminishedSeventh: return [3, 3, 3]
        case DominantSeventhFlatFive: return [4, 2, 4]
        case MajorSeventhFlatFive: return [4, 2, 5]
        case DominantSeventhSusFour: return [5, 2, 3]
        case MajorSeventhSusFour: return [5, 2, 4]
        case MajorSixth: return [4, 3, 2]
        case MinorSixth: return [3, 4, 2]
        case AddNine: return [2, 2, 3]
        case MinorAddNine: return [2, 1, 4]
        // pentads
        case DominantNinth: return [4, 3, 3, 4]
        case DominantMinorNinth: return [4, 3, 3, 3]
        case MajorNinth: return [4, 3, 4, 3]
        case SixNine: return [4, 3, 1, 5]
        }
    }
}
