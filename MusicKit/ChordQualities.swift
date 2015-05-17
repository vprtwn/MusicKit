import Foundation

public extension ChordQuality {
public static let Dyads = [
ChordQuality.PowerChord,
]
public static let Triads = [
ChordQuality.Major,
ChordQuality.Minor,
ChordQuality.Augmented,
ChordQuality.Diminished,
ChordQuality.Sus2,
ChordQuality.Sus4,
]
public static let UnalteredTetrads = [
ChordQuality.DominantSeventh,
ChordQuality.MajorSeventh,
ChordQuality.MinorMajorSeventh,
ChordQuality.MinorSeventh,
ChordQuality.AugmentedMajorSeventh,
ChordQuality.AugmentedSeventh,
ChordQuality.HalfDiminishedSeventh,
ChordQuality.DiminishedSeventh,
]
public static let AlteredTetrads = [
ChordQuality.DominantSeventhFlatFive,
ChordQuality.MajorSeventhFlatFive,
ChordQuality.DominantSeventhSusFour,
ChordQuality.MajorSeventhSusFour,
ChordQuality.MajorSixth,
ChordQuality.MinorSixth,
ChordQuality.AddNine,
ChordQuality.MinorAddNine,
ChordQuality.AddEleven,
ChordQuality.MinorAddEleven,
ChordQuality.AddSharpEleven,
ChordQuality.MinorAddSharpEleven,
]
public static let Pentads = [
ChordQuality.DominantNinth,
ChordQuality.MajorNinth,
ChordQuality.MinorNinth,
ChordQuality.MinorMajorNinth,
ChordQuality.AugmentedNinth,
ChordQuality.AugmentedMajorNinth,
ChordQuality.HalfDiminishedNinth,
ChordQuality.DiminishedNinth,
ChordQuality.Dominant9Sus4,
ChordQuality.SixNine,
ChordQuality.HalfDiminishedMinorNinth,
ChordQuality.DiminishedMinorNinth,
ChordQuality.DominantSeventhSharpNine,
ChordQuality.MajorSeventhSharpNine,
ChordQuality.AugmentedSeventhSharpNine,
ChordQuality.AugmentedMajorSeventhSharpNine,
ChordQuality.DominantSeventhFlatNine,
ChordQuality.MinorSeventhFlatNine,
ChordQuality.MajorSeventhFlatNine,
ChordQuality.MinorMajorSeventhFlatNine,
ChordQuality.AugmentedSeventhFlatNine,
ChordQuality.AugmentedMajorSeventhFlatNine,
ChordQuality.DominantSeventhSharpEleven,
ChordQuality.MinorSeventhSharpEleven,
ChordQuality.MajorSeventhSharpEleven,
ChordQuality.MinorMajorSeventhSharpEleven,
ChordQuality.AugmentedSeventhSharpEleven,
ChordQuality.AugmentedMajorSeventhSharpEleven,
]
public static let Hexads = [
ChordQuality.DominantEleventh,
ChordQuality.MajorEleventh,
ChordQuality.MinorMajorEleventh,
ChordQuality.MinorEleventh,
ChordQuality.AugmentedMajorEleventh,
ChordQuality.AugmentedEleventh,
ChordQuality.HalfDiminishedEleventh,
ChordQuality.DiminishedEleventh,
ChordQuality.DominantEleventhFlatNine,
ChordQuality.MajorEleventhFlatNine,
ChordQuality.MinorEleventhFlatNine,
ChordQuality.DominantNinthSharpEleven,
ChordQuality.MajorNinthSharpEleven,
ChordQuality.MinorNinthSharpEleven,
]
public static let Heptads = [
ChordQuality.DominantThirteenth,
ChordQuality.MajorThirteenth,
ChordQuality.MinorMajorThirteenth,
ChordQuality.MinorThirteenth,
ChordQuality.AugmentedMajorThirteenth,
ChordQuality.AugmentedThirteenth,
ChordQuality.HalfDiminishedThirteenth,
]
public static let Tetrads = ChordQuality.UnalteredTetrads + ChordQuality.AlteredTetrads
public static let All = [
ChordQuality.PowerChord,
ChordQuality.Major,
ChordQuality.Minor,
ChordQuality.Augmented,
ChordQuality.Diminished,
ChordQuality.Sus2,
ChordQuality.Sus4,
ChordQuality.DominantSeventh,
ChordQuality.MajorSeventh,
ChordQuality.MinorMajorSeventh,
ChordQuality.MinorSeventh,
ChordQuality.AugmentedMajorSeventh,
ChordQuality.AugmentedSeventh,
ChordQuality.HalfDiminishedSeventh,
ChordQuality.DiminishedSeventh,
ChordQuality.DominantSeventhFlatFive,
ChordQuality.MajorSeventhFlatFive,
ChordQuality.DominantSeventhSusFour,
ChordQuality.MajorSeventhSusFour,
ChordQuality.MajorSixth,
ChordQuality.MinorSixth,
ChordQuality.AddNine,
ChordQuality.MinorAddNine,
ChordQuality.AddEleven,
ChordQuality.MinorAddEleven,
ChordQuality.AddSharpEleven,
ChordQuality.MinorAddSharpEleven,
ChordQuality.DominantNinth,
ChordQuality.MajorNinth,
ChordQuality.MinorNinth,
ChordQuality.MinorMajorNinth,
ChordQuality.AugmentedNinth,
ChordQuality.AugmentedMajorNinth,
ChordQuality.HalfDiminishedNinth,
ChordQuality.DiminishedNinth,
ChordQuality.Dominant9Sus4,
ChordQuality.SixNine,
ChordQuality.HalfDiminishedMinorNinth,
ChordQuality.DiminishedMinorNinth,
ChordQuality.DominantSeventhSharpNine,
ChordQuality.MajorSeventhSharpNine,
ChordQuality.AugmentedSeventhSharpNine,
ChordQuality.AugmentedMajorSeventhSharpNine,
ChordQuality.DominantSeventhFlatNine,
ChordQuality.MinorSeventhFlatNine,
ChordQuality.MajorSeventhFlatNine,
ChordQuality.MinorMajorSeventhFlatNine,
ChordQuality.AugmentedSeventhFlatNine,
ChordQuality.AugmentedMajorSeventhFlatNine,
ChordQuality.DominantSeventhSharpEleven,
ChordQuality.MinorSeventhSharpEleven,
ChordQuality.MajorSeventhSharpEleven,
ChordQuality.MinorMajorSeventhSharpEleven,
ChordQuality.AugmentedSeventhSharpEleven,
ChordQuality.AugmentedMajorSeventhSharpEleven,
ChordQuality.DominantEleventh,
ChordQuality.MajorEleventh,
ChordQuality.MinorMajorEleventh,
ChordQuality.MinorEleventh,
ChordQuality.AugmentedMajorEleventh,
ChordQuality.AugmentedEleventh,
ChordQuality.HalfDiminishedEleventh,
ChordQuality.DiminishedEleventh,
ChordQuality.DominantEleventhFlatNine,
ChordQuality.MajorEleventhFlatNine,
ChordQuality.MinorEleventhFlatNine,
ChordQuality.DominantNinthSharpEleven,
ChordQuality.MajorNinthSharpEleven,
ChordQuality.MinorNinthSharpEleven,
ChordQuality.DominantThirteenth,
ChordQuality.MajorThirteenth,
ChordQuality.MinorMajorThirteenth,
ChordQuality.MinorThirteenth,
ChordQuality.AugmentedMajorThirteenth,
ChordQuality.AugmentedThirteenth,
ChordQuality.HalfDiminishedThirteenth,
]
public var name : String {
switch self {
case PowerChord: return "PowerChord"
case Major: return "Major"
case Minor: return "Minor"
case Augmented: return "Augmented"
case Diminished: return "Diminished"
case Sus2: return "Sus2"
case Sus4: return "Sus4"
case DominantSeventh: return "DominantSeventh"
case MajorSeventh: return "MajorSeventh"
case MinorMajorSeventh: return "MinorMajorSeventh"
case MinorSeventh: return "MinorSeventh"
case AugmentedMajorSeventh: return "AugmentedMajorSeventh"
case AugmentedSeventh: return "AugmentedSeventh"
case HalfDiminishedSeventh: return "HalfDiminishedSeventh"
case DiminishedSeventh: return "DiminishedSeventh"
case DominantSeventhFlatFive: return "DominantSeventhFlatFive"
case MajorSeventhFlatFive: return "MajorSeventhFlatFive"
case DominantSeventhSusFour: return "DominantSeventhSusFour"
case MajorSeventhSusFour: return "MajorSeventhSusFour"
case MajorSixth: return "MajorSixth"
case MinorSixth: return "MinorSixth"
case AddNine: return "AddNine"
case MinorAddNine: return "MinorAddNine"
case AddEleven: return "AddEleven"
case MinorAddEleven: return "MinorAddEleven"
case AddSharpEleven: return "AddSharpEleven"
case MinorAddSharpEleven: return "MinorAddSharpEleven"
case DominantNinth: return "DominantNinth"
case MajorNinth: return "MajorNinth"
case MinorNinth: return "MinorNinth"
case MinorMajorNinth: return "MinorMajorNinth"
case AugmentedNinth: return "AugmentedNinth"
case AugmentedMajorNinth: return "AugmentedMajorNinth"
case HalfDiminishedNinth: return "HalfDiminishedNinth"
case DiminishedNinth: return "DiminishedNinth"
case Dominant9Sus4: return "Dominant9Sus4"
case SixNine: return "SixNine"
case HalfDiminishedMinorNinth: return "HalfDiminishedMinorNinth"
case DiminishedMinorNinth: return "DiminishedMinorNinth"
case DominantSeventhSharpNine: return "DominantSeventhSharpNine"
case MajorSeventhSharpNine: return "MajorSeventhSharpNine"
case AugmentedSeventhSharpNine: return "AugmentedSeventhSharpNine"
case AugmentedMajorSeventhSharpNine: return "AugmentedMajorSeventhSharpNine"
case DominantSeventhFlatNine: return "DominantSeventhFlatNine"
case MinorSeventhFlatNine: return "MinorSeventhFlatNine"
case MajorSeventhFlatNine: return "MajorSeventhFlatNine"
case MinorMajorSeventhFlatNine: return "MinorMajorSeventhFlatNine"
case AugmentedSeventhFlatNine: return "AugmentedSeventhFlatNine"
case AugmentedMajorSeventhFlatNine: return "AugmentedMajorSeventhFlatNine"
case DominantSeventhSharpEleven: return "DominantSeventhSharpEleven"
case MinorSeventhSharpEleven: return "MinorSeventhSharpEleven"
case MajorSeventhSharpEleven: return "MajorSeventhSharpEleven"
case MinorMajorSeventhSharpEleven: return "MinorMajorSeventhSharpEleven"
case AugmentedSeventhSharpEleven: return "AugmentedSeventhSharpEleven"
case AugmentedMajorSeventhSharpEleven: return "AugmentedMajorSeventhSharpEleven"
case DominantEleventh: return "DominantEleventh"
case MajorEleventh: return "MajorEleventh"
case MinorMajorEleventh: return "MinorMajorEleventh"
case MinorEleventh: return "MinorEleventh"
case AugmentedMajorEleventh: return "AugmentedMajorEleventh"
case AugmentedEleventh: return "AugmentedEleventh"
case HalfDiminishedEleventh: return "HalfDiminishedEleventh"
case DiminishedEleventh: return "DiminishedEleventh"
case DominantEleventhFlatNine: return "DominantEleventhFlatNine"
case MajorEleventhFlatNine: return "MajorEleventhFlatNine"
case MinorEleventhFlatNine: return "MinorEleventhFlatNine"
case DominantNinthSharpEleven: return "DominantNinthSharpEleven"
case MajorNinthSharpEleven: return "MajorNinthSharpEleven"
case MinorNinthSharpEleven: return "MinorNinthSharpEleven"
case DominantThirteenth: return "DominantThirteenth"
case MajorThirteenth: return "MajorThirteenth"
case MinorMajorThirteenth: return "MinorMajorThirteenth"
case MinorThirteenth: return "MinorThirteenth"
case AugmentedMajorThirteenth: return "AugmentedMajorThirteenth"
case AugmentedThirteenth: return "AugmentedThirteenth"
case HalfDiminishedThirteenth: return "HalfDiminishedThirteenth"
}
}
}
