//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum ChordQuality : String {
    //: Dyads
    case PowerChord = "5"
    //> Triads
    case Major = "M"
    case Minor = "m"
    case Augmented = "+"
    case Diminished = "°"
    case Sus2 = "sus2"
    case Sus4 = "sus4"
    //> UnalteredTetrads
    case DominantSeventh = "7"
    case MajorSeventh = "Δ7"
    case MinorMajorSeventh = "mΔ7"
    case MinorSeventh = "m7"
    case AugmentedMajorSeventh = "+Δ7"
    case AugmentedSeventh = "+7"
    case HalfDiminishedSeventh = "ø7"
    case DiminishedSeventh = "°7"
    //> AlteredTetrads
    case DominantSeventhFlatFive = "7♭5"
    case MajorSeventhFlatFive = "Δ7♭5"
    case DominantSeventhSusFour = "7sus4"
    case MajorSeventhSusFour = "Δ7sus4"
    case MajorSixth = "6"
    case MinorSixth = "m6"
    case AddNine = "add9"
    case MinorAddNine = "madd9"
    case AddEleven = "add11"
    case MinorAddEleven = "madd11"
    case AugmentedAddEleven = "+add11"
    case DiminishedAddEleven = "°add11"
    case AddSharpEleven = "add♯11"
    case MinorAddSharpEleven = "madd♯11"
    case AugmentedAddSharpEleven = "+add♯11"
    //> Pentads
    // unaltered pentads
    case DominantNinth = "9"
    case MajorNinth = "Δ9"
    case MinorMajorNinth = "mΔ9"
    case MinorNinth = "m9"
    case AugmentedMajorNinth = "+Δ9"
    case AugmentedNinth = "+9"
    case HalfDiminishedNinth = "ø9"
    case DiminishedNinth = "°9"
    // flat nine pentads
    case DominantSeventhFlatNine = "7♭9"
    case MajorSeventhFlatNine = "Δ7♭9"
    case MinorMajorSeventhFlatNine = "mΔ7♭9"
    case MinorSeventhFlatNine = "m7♭9"
    case AugmentedMajorSeventhFlatNine = "+Δ7♭9"
    case AugmentedSeventhFlatNine = "+7♭9"
    case HalfDiminishedSeventhFlatNine = "ø7♭9"
    case DiminishedSeventhFlatNine = "°7♭9"
    // sharp eleven pentads
    case DominantSeventhSharpEleven = "7♯11"
    case MajorSeventhSharpEleven = "Δ7♯11"
    case MinorMajorSeventhSharpEleven = "mΔ7♯11"
    case MinorSeventhSharpEleven = "m7♯11"
    case AugmentedMajorSeventhSharpEleven = "+Δ7♯11"
    case AugmentedSeventhSharpEleven = "+7♯11"
    // flat thirteen pentads
    case DominantSeventhFlatThirteen = "7♭13"
    case MajorSeventhFlatThirteen = "Δ7♭13"
    case MinorMajorSeventhFlatThirteen = "mΔ7♭13"
    case MinorSeventhFlatThirteen = "m7♭13"
    case HalfDiminishedSeventhFlatThirteen = "ø7♭13"
    case DiminishedSeventhFlatThirteen = "°7♭13"
    // other pentads
    case Dominant9Sus4 = "9sus4"
    case SixNine = "6/9"
    //> Hexads
    // unaltered hexads
    case DominantEleventh = "11"
    case MajorEleventh = "Δ11"
    case MinorMajorEleventh = "mΔ11"
    case MinorEleventh = "m11"
    case AugmentedMajorEleventh = "+Δ11"
    case AugmentedEleventh = "+11"
    case HalfDiminishedEleventh = "ø11"
    case DiminishedEleventh = "°11"
    // altered hexads
    case DominantEleventhFlatNine = "11♭9"
    case MajorEleventhFlatNine = "Δ11♭9"
    case MinorEleventhFlatNine = "m11♭9"
    case DominantNinthSharpEleven = "9♯11"
    case MajorNinthSharpEleven = "Δ9♯11"
    case MinorNinthSharpEleven = "m9♯11"
    //> Heptads
    // unaltered heptads
    case DominantThirteenth = "13"
    case MajorThirteenth = "Δ13"
    case MinorMajorThirteenth = "mΔ13"
    case MinorThirteenth = "m13"
    case AugmentedMajorThirteenth = "+Δ13"
    case AugmentedThirteenth = "+13"
    case HalfDiminishedThirteenth = "ø13"
    case DiminishedThirteenth = "°13"
    // altered heptads
    //.

    public var intervals: [Float] {
        switch self {
        // dyads
        case PowerChord: return [7]
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
        case AddEleven: return [4, 1, 2]
        case MinorAddEleven: return [3, 2, 2]
        case AugmentedAddEleven: return [4, 1, 3]
        case DiminishedAddEleven: return [3, 2, 1]
        case AddSharpEleven: return [4, 2, 1]
        case MinorAddSharpEleven: return [3, 3, 1]
        case AugmentedAddSharpEleven: return [4, 2, 2]
        // pentads
        // unaltered pentads
        case DominantNinth: return [4, 3, 3, 4]
        case MajorNinth: return [4, 3, 4, 3]
        case MinorMajorNinth: return [3, 4, 4, 3]
        case MinorNinth: return [3, 4, 3, 4]
        case AugmentedMajorNinth: return [4, 4, 3, 3]
        case AugmentedNinth: return [4, 4, 2, 4]
        case HalfDiminishedNinth: return [3, 3, 4, 4]
        case DiminishedNinth: return [3, 3, 3, 5]
        // flat nine pentads
        case DominantSeventhFlatNine: return [4, 3, 3, 3]
        case MajorSeventhFlatNine: return [4, 3, 4, 2]
        case MinorMajorSeventhFlatNine: return [3, 4, 4, 2]
        case MinorSeventhFlatNine: return [3, 4, 3, 3]
        case AugmentedMajorSeventhFlatNine: return [4, 4, 3, 2]
        case AugmentedSeventhFlatNine: return [4, 4, 2, 3]
        case HalfDiminishedSeventhFlatNine: return [3, 3, 4, 3]
        case DiminishedSeventhFlatNine: return [3, 3, 3, 4]
        // sharp eleven pentads
        case DominantSeventhSharpEleven: return [4, 3, 3, 8]
        case MajorSeventhSharpEleven: return [4, 3, 4, 7]
        case MinorMajorSeventhSharpEleven: return [3, 4, 4, 7]
        case MinorSeventhSharpEleven: return [3, 4, 3, 8]
        case AugmentedMajorSeventhSharpEleven: return [4, 4, 3, 7]
        case AugmentedSeventhSharpEleven: return [4, 4, 2, 8]
        // flat thirteen pentads
        case DominantSeventhFlatThirteen: return [4, 3, 3, 10]
        case MajorSeventhFlatThirteen: return [4, 3, 4, 9]
        case MinorMajorSeventhFlatThirteen: return [3, 4, 4, 9]
        case MinorSeventhFlatThirteen: return [3, 4, 3, 10]
        case HalfDiminishedSeventhFlatThirteen: return [3, 3, 4, 10]
        case DiminishedSeventhFlatThirteen: return [3, 3, 3, 11]
        // other pentads
        case SixNine: return [4, 3, 1, 5]
        case Dominant9Sus4: return [5, 2, 3, 4]
        // hexads
        // unaltered hexads
        case DominantEleventh: return [4, 3, 3, 4, 3]
        case MajorEleventh: return [4, 3, 4, 3, 3]
        case MinorMajorEleventh: return [3, 4, 4, 3, 3]
        case MinorEleventh: return [3, 4, 3, 4, 3]
        case AugmentedMajorEleventh: return [4, 4, 3, 3, 3]
        case AugmentedEleventh: return [4, 4, 2, 4, 3]
        case HalfDiminishedEleventh: return [3, 3, 4, 4, 3]
        case DiminishedEleventh: return [3, 3, 3, 5, 3]
        // altered
        case DominantEleventhFlatNine: return [4, 3, 3, 3, 4]
        case MajorEleventhFlatNine: return [4, 3, 4, 2, 4]
        case MinorEleventhFlatNine: return [3, 4, 3, 3, 4]
        case DominantNinthSharpEleven: return [4, 3, 3, 4, 4]
        case MajorNinthSharpEleven: return [4, 3, 4, 3, 4]
        case MinorNinthSharpEleven: return [3, 4, 3, 4, 4]
        // heptads
        // unaltered heptads
        case DominantThirteenth: return [4, 3, 3, 4, 3, 4]
        case MajorThirteenth: return [4, 3, 4, 3, 3, 4]
        case MinorMajorThirteenth: return [3, 4, 4, 3, 3, 4]
        case MinorThirteenth: return [3, 4, 3, 4, 3, 4]
        case AugmentedMajorThirteenth: return [4, 4, 3, 3, 3, 4]
        case AugmentedThirteenth: return [4, 4, 2, 4, 3, 4]
        case HalfDiminishedThirteenth: return [3, 3, 4, 4, 3, 4]
        case DiminishedThirteenth: return [3, 3, 3, 5, 3, 4]
        }
    }
}

extension ChordQuality : Printable {
    public var description : String {
        return rawValue
    }
}
