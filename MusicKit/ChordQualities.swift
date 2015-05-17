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
ChordQuality.AugmentedAddEleven,
ChordQuality.DiminishedAddEleven,
ChordQuality.AddSharpEleven,
ChordQuality.MinorAddSharpEleven,
ChordQuality.AugmentedAddSharpEleven,
]
public static let Pentads = [
ChordQuality.DominantNinth,
ChordQuality.MajorNinth,
ChordQuality.MinorMajorNinth,
ChordQuality.MinorNinth,
ChordQuality.AugmentedMajorNinth,
ChordQuality.AugmentedNinth,
ChordQuality.HalfDiminishedNinth,
ChordQuality.DiminishedNinth,
ChordQuality.DominantSeventhFlatNine,
ChordQuality.MajorSeventhFlatNine,
ChordQuality.MinorMajorSeventhFlatNine,
ChordQuality.MinorSeventhFlatNine,
ChordQuality.AugmentedMajorSeventhFlatNine,
ChordQuality.AugmentedSeventhFlatNine,
ChordQuality.HalfDiminishedSeventhFlatNine,
ChordQuality.DiminishedSeventhFlatNine,
ChordQuality.DominantSeventhSharpEleven,
ChordQuality.MajorSeventhSharpEleven,
ChordQuality.MinorMajorSeventhSharpEleven,
ChordQuality.MinorSeventhSharpEleven,
ChordQuality.AugmentedMajorSeventhSharpEleven,
ChordQuality.AugmentedSeventhSharpEleven,
ChordQuality.DominantSeventhFlatThirteen,
ChordQuality.MajorSeventhFlatThirteen,
ChordQuality.MinorMajorSeventhFlatThirteen,
ChordQuality.MinorSeventhFlatThirteen,
ChordQuality.HalfDiminishedSeventhFlatThirteen,
ChordQuality.DiminishedSeventhFlatThirteen,
ChordQuality.Dominant9Sus4,
ChordQuality.SixNine,
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
ChordQuality.MinorMajorEleventhFlatNine,
ChordQuality.MinorEleventhFlatNine,
ChordQuality.AugmentedMajorEleventhFlatNine,
ChordQuality.AugmentedEleventhFlatNine,
ChordQuality.HalfDiminishedEleventhFlatNine,
ChordQuality.DiminishedEleventhFlatNine,
ChordQuality.DominantNinthSharpEleven,
ChordQuality.MajorNinthSharpEleven,
ChordQuality.MinorMajorNinthSharpEleven,
ChordQuality.MinorNinthSharpEleven,
ChordQuality.AugmentedMajorNinthSharpEleven,
ChordQuality.AugmentedNinthSharpEleven,
ChordQuality.DominantNinthFlatThirteen,
ChordQuality.MajorNinthFlatThirteen,
ChordQuality.MinorMajorNinthFlatThirteen,
ChordQuality.MinorNinthFlatThirteen,
ChordQuality.HalfDiminishedNinthFlatThirteen,
ChordQuality.DiminishedNinthFlatThirteen,
]
public static let Heptads = [
ChordQuality.DominantThirteenth,
ChordQuality.MajorThirteenth,
ChordQuality.MinorMajorThirteenth,
ChordQuality.MinorThirteenth,
ChordQuality.AugmentedMajorThirteenth,
ChordQuality.AugmentedThirteenth,
ChordQuality.HalfDiminishedThirteenth,
ChordQuality.DiminishedThirteenth,
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
ChordQuality.AugmentedAddEleven,
ChordQuality.DiminishedAddEleven,
ChordQuality.AddSharpEleven,
ChordQuality.MinorAddSharpEleven,
ChordQuality.AugmentedAddSharpEleven,
ChordQuality.DominantNinth,
ChordQuality.MajorNinth,
ChordQuality.MinorMajorNinth,
ChordQuality.MinorNinth,
ChordQuality.AugmentedMajorNinth,
ChordQuality.AugmentedNinth,
ChordQuality.HalfDiminishedNinth,
ChordQuality.DiminishedNinth,
ChordQuality.DominantSeventhFlatNine,
ChordQuality.MajorSeventhFlatNine,
ChordQuality.MinorMajorSeventhFlatNine,
ChordQuality.MinorSeventhFlatNine,
ChordQuality.AugmentedMajorSeventhFlatNine,
ChordQuality.AugmentedSeventhFlatNine,
ChordQuality.HalfDiminishedSeventhFlatNine,
ChordQuality.DiminishedSeventhFlatNine,
ChordQuality.DominantSeventhSharpEleven,
ChordQuality.MajorSeventhSharpEleven,
ChordQuality.MinorMajorSeventhSharpEleven,
ChordQuality.MinorSeventhSharpEleven,
ChordQuality.AugmentedMajorSeventhSharpEleven,
ChordQuality.AugmentedSeventhSharpEleven,
ChordQuality.DominantSeventhFlatThirteen,
ChordQuality.MajorSeventhFlatThirteen,
ChordQuality.MinorMajorSeventhFlatThirteen,
ChordQuality.MinorSeventhFlatThirteen,
ChordQuality.HalfDiminishedSeventhFlatThirteen,
ChordQuality.DiminishedSeventhFlatThirteen,
ChordQuality.Dominant9Sus4,
ChordQuality.SixNine,
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
ChordQuality.MinorMajorEleventhFlatNine,
ChordQuality.MinorEleventhFlatNine,
ChordQuality.AugmentedMajorEleventhFlatNine,
ChordQuality.AugmentedEleventhFlatNine,
ChordQuality.HalfDiminishedEleventhFlatNine,
ChordQuality.DiminishedEleventhFlatNine,
ChordQuality.DominantNinthSharpEleven,
ChordQuality.MajorNinthSharpEleven,
ChordQuality.MinorMajorNinthSharpEleven,
ChordQuality.MinorNinthSharpEleven,
ChordQuality.AugmentedMajorNinthSharpEleven,
ChordQuality.AugmentedNinthSharpEleven,
ChordQuality.DominantNinthFlatThirteen,
ChordQuality.MajorNinthFlatThirteen,
ChordQuality.MinorMajorNinthFlatThirteen,
ChordQuality.MinorNinthFlatThirteen,
ChordQuality.HalfDiminishedNinthFlatThirteen,
ChordQuality.DiminishedNinthFlatThirteen,
ChordQuality.DominantThirteenth,
ChordQuality.MajorThirteenth,
ChordQuality.MinorMajorThirteenth,
ChordQuality.MinorThirteenth,
ChordQuality.AugmentedMajorThirteenth,
ChordQuality.AugmentedThirteenth,
ChordQuality.HalfDiminishedThirteenth,
ChordQuality.DiminishedThirteenth,
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
case AugmentedAddEleven: return "AugmentedAddEleven"
case DiminishedAddEleven: return "DiminishedAddEleven"
case AddSharpEleven: return "AddSharpEleven"
case MinorAddSharpEleven: return "MinorAddSharpEleven"
case AugmentedAddSharpEleven: return "AugmentedAddSharpEleven"
case DominantNinth: return "DominantNinth"
case MajorNinth: return "MajorNinth"
case MinorMajorNinth: return "MinorMajorNinth"
case MinorNinth: return "MinorNinth"
case AugmentedMajorNinth: return "AugmentedMajorNinth"
case AugmentedNinth: return "AugmentedNinth"
case HalfDiminishedNinth: return "HalfDiminishedNinth"
case DiminishedNinth: return "DiminishedNinth"
case DominantSeventhFlatNine: return "DominantSeventhFlatNine"
case MajorSeventhFlatNine: return "MajorSeventhFlatNine"
case MinorMajorSeventhFlatNine: return "MinorMajorSeventhFlatNine"
case MinorSeventhFlatNine: return "MinorSeventhFlatNine"
case AugmentedMajorSeventhFlatNine: return "AugmentedMajorSeventhFlatNine"
case AugmentedSeventhFlatNine: return "AugmentedSeventhFlatNine"
case HalfDiminishedSeventhFlatNine: return "HalfDiminishedSeventhFlatNine"
case DiminishedSeventhFlatNine: return "DiminishedSeventhFlatNine"
case DominantSeventhSharpEleven: return "DominantSeventhSharpEleven"
case MajorSeventhSharpEleven: return "MajorSeventhSharpEleven"
case MinorMajorSeventhSharpEleven: return "MinorMajorSeventhSharpEleven"
case MinorSeventhSharpEleven: return "MinorSeventhSharpEleven"
case AugmentedMajorSeventhSharpEleven: return "AugmentedMajorSeventhSharpEleven"
case AugmentedSeventhSharpEleven: return "AugmentedSeventhSharpEleven"
case DominantSeventhFlatThirteen: return "DominantSeventhFlatThirteen"
case MajorSeventhFlatThirteen: return "MajorSeventhFlatThirteen"
case MinorMajorSeventhFlatThirteen: return "MinorMajorSeventhFlatThirteen"
case MinorSeventhFlatThirteen: return "MinorSeventhFlatThirteen"
case HalfDiminishedSeventhFlatThirteen: return "HalfDiminishedSeventhFlatThirteen"
case DiminishedSeventhFlatThirteen: return "DiminishedSeventhFlatThirteen"
case Dominant9Sus4: return "Dominant9Sus4"
case SixNine: return "SixNine"
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
case MinorMajorEleventhFlatNine: return "MinorMajorEleventhFlatNine"
case MinorEleventhFlatNine: return "MinorEleventhFlatNine"
case AugmentedMajorEleventhFlatNine: return "AugmentedMajorEleventhFlatNine"
case AugmentedEleventhFlatNine: return "AugmentedEleventhFlatNine"
case HalfDiminishedEleventhFlatNine: return "HalfDiminishedEleventhFlatNine"
case DiminishedEleventhFlatNine: return "DiminishedEleventhFlatNine"
case DominantNinthSharpEleven: return "DominantNinthSharpEleven"
case MajorNinthSharpEleven: return "MajorNinthSharpEleven"
case MinorMajorNinthSharpEleven: return "MinorMajorNinthSharpEleven"
case MinorNinthSharpEleven: return "MinorNinthSharpEleven"
case AugmentedMajorNinthSharpEleven: return "AugmentedMajorNinthSharpEleven"
case AugmentedNinthSharpEleven: return "AugmentedNinthSharpEleven"
case DominantNinthFlatThirteen: return "DominantNinthFlatThirteen"
case MajorNinthFlatThirteen: return "MajorNinthFlatThirteen"
case MinorMajorNinthFlatThirteen: return "MinorMajorNinthFlatThirteen"
case MinorNinthFlatThirteen: return "MinorNinthFlatThirteen"
case HalfDiminishedNinthFlatThirteen: return "HalfDiminishedNinthFlatThirteen"
case DiminishedNinthFlatThirteen: return "DiminishedNinthFlatThirteen"
case DominantThirteenth: return "DominantThirteenth"
case MajorThirteenth: return "MajorThirteenth"
case MinorMajorThirteenth: return "MinorMajorThirteenth"
case MinorThirteenth: return "MinorThirteenth"
case AugmentedMajorThirteenth: return "AugmentedMajorThirteenth"
case AugmentedThirteenth: return "AugmentedThirteenth"
case HalfDiminishedThirteenth: return "HalfDiminishedThirteenth"
case DiminishedThirteenth: return "DiminishedThirteenth"
}
}
}
