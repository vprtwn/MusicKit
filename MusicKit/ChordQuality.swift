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
    case DominantSeventhSharpNine
    case MajorNinth
    case MinorNinth
    case MinorMajorNinth
    case AugmentedNinth
    case AugmentedMajorNinth
    case HalfDiminishedNinth
    case HalfDiminishedMinorNinth
    case DiminishedNinth
    case DiminishedMinorNinth
    case SixNine
    case Dominant9Sus4
    // hexads
    case DominantEleventh
    case MajorEleventh
    case MinorMajorEleventh
    case MinorEleventh
    case AugmentedMajorEleventh
    case AugmentedEleventh
    case HalfDiminishedEleventh
    case DiminishedEleventh
    case DominantNinthSharpEleven
    // heptads
    case DominantThirteenth
    case MajorThirteenth
    case MinorMajorThirteenth
    case MinorThirteenth
    case AugmentedMajorThirteenth
    case AugmentedThirteenth
    case HalfDiminishedThirteenth

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
        // pentads
        case DominantNinth: return "dominant ninth"
        case DominantMinorNinth: return "dominant minor ninth"
        case DominantSeventhSharpNine: return "dominant seventh sharp nine"
        case MajorNinth: return "major ninth"
        case MinorNinth: return "minor ninth"
        case MinorMajorNinth: return "minor major ninth"
        case AugmentedNinth: return "augmented ninth"
        case AugmentedMajorNinth: return "augmented major ninth"
        case HalfDiminishedNinth: return "half diminished ninth"
        case HalfDiminishedMinorNinth: return "half diminished minor ninth"
        case DiminishedNinth: return "diminished ninth"
        case DiminishedMinorNinth: return "diminished minor ninth"
        case SixNine: return "six nine"
        case Dominant9Sus4: return "domininant ninth sus four"
        // hexads
        case DominantEleventh: return "dominant eleventh"
        case MajorEleventh: return "major eleventh"
        case MinorMajorEleventh: return "minor major eleventh"
        case MinorEleventh: return "minor eleventh"
        case AugmentedMajorEleventh: return "augmented major eleventh"
        case AugmentedEleventh: return "augmented eleventh"
        case HalfDiminishedEleventh: return "half diminished eleventh"
        case DiminishedEleventh: return "diminished eleventh"
        case DominantNinthSharpEleven: return "dominant ninth sharp eleven"
        // heptads
        case DominantThirteenth: return "dominant thirteenth"
        case MajorThirteenth: return "major thirteenth"
        case MinorMajorThirteenth: return "minor major thirteenth"
        case MinorThirteenth: return "minor thirteenth"
        case AugmentedMajorThirteenth: return "augmented major thirteenth"
        case AugmentedThirteenth: return "augmented thirteenth"
        case HalfDiminishedThirteenth: return "half diminished thirteenth"
        }
    }

    public var shortName: String {
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
        case DominantSeventhSharpNine: return "7♯9"
        case MajorNinth: return "Δ9"
        case MinorNinth: return "m9"
        case MinorMajorNinth: return "mΔ9"
        case AugmentedNinth: return "+9"
        case AugmentedMajorNinth: return "+Δ9"
        case HalfDiminishedNinth: return "ø9"
        case HalfDiminishedMinorNinth: return "ø♭9"
        case DiminishedNinth: return "°9"
        case DiminishedMinorNinth: return "°♭9"
        case SixNine: return "6/9"
        case Dominant9Sus4: return "9sus4"
        // hexads
        case DominantEleventh: return "11"
        case MajorEleventh: return "Δ11"
        case MinorMajorEleventh: return "mΔ11"
        case MinorEleventh: return "m11"
        case AugmentedMajorEleventh: return "+Δ11"
        case AugmentedEleventh: return "+11"
        case HalfDiminishedEleventh: return "ø11"
        case DiminishedEleventh: return "°11"
        case DominantNinthSharpEleven: return "9♯11"
        // heptads
        case DominantThirteenth: return "13"
        case MajorThirteenth: return "Δ13"
        case MinorMajorThirteenth: return "mΔ13"
        case MinorThirteenth: return "m13"
        case AugmentedMajorThirteenth: return "+Δ13"
        case AugmentedThirteenth: return "+13"
        case HalfDiminishedThirteenth: return "ø11"
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
        case DominantSeventhSharpNine: return [4, 3, 3, 5]
        case MajorNinth: return [4, 3, 4, 3]
        case MinorNinth: return [3, 4, 3, 4]
        case MinorMajorNinth: return [3, 4, 4, 3]
        case AugmentedNinth: return [4, 4, 2, 4]
        case AugmentedMajorNinth: return [4, 4, 3, 3]
        case HalfDiminishedNinth: return [3, 3, 4, 4]
        case HalfDiminishedMinorNinth: return [3, 3, 4, 3]
        case DiminishedNinth: return [3, 3, 3, 5]
        case DiminishedMinorNinth: return [3, 3, 3, 4]
        case SixNine: return [4, 3, 1, 5]
        case Dominant9Sus4: return [5, 2, 3, 4]
        // hexads
        case DominantEleventh: return [4, 3, 3, 4, 3]
        case MajorEleventh: return [4, 3, 4, 3, 3]
        case MinorMajorEleventh: return [3, 4, 4, 3, 3]
        case MinorEleventh: return [3, 4, 3, 4, 3]
        case AugmentedMajorEleventh: return [4, 4, 3, 3, 3]
        case AugmentedEleventh: return [4, 4, 2, 4, 3]
        case HalfDiminishedEleventh: return [3, 3, 4, 4, 3]
        case DiminishedEleventh: return [3, 3, 3, 5, 3]
        case DominantNinthSharpEleven: return [4, 3, 3, 4, 4]
        // heptads
        case DominantThirteenth: return [4, 3, 3, 4, 3, 4]
        case MajorThirteenth: return [4, 3, 4, 3, 3, 4]
        case MinorMajorThirteenth: return [3, 4, 4, 3, 3, 4]
        case MinorThirteenth: return [3, 4, 3, 4, 3, 4]
        case AugmentedMajorThirteenth: return [4, 4, 3, 3, 3, 4]
        case AugmentedThirteenth: return [3, 3, 4, 4, 3, 4]
        case HalfDiminishedThirteenth: return [3, 3, 4, 4, 3, 4]
        }
    }
}
