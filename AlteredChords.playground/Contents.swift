import MusicKit

let altExtensions = [
    ChordExtension.FlatNine,
    ChordExtension.SharpEleven,
    ChordExtension.FlatThirteen
]

let unaltered = [
    ChordQuality.DominantSeventh,
    ChordQuality.MajorSeventh,
    ChordQuality.MinorMajorSeventh,
    ChordQuality.MinorSeventh,
    ChordQuality.AugmentedMajorSeventh,
    ChordQuality.AugmentedSeventh,
    ChordQuality.HalfDiminishedSeventh,
    ChordQuality.DiminishedSeventh,
]

let flatFives = [
    ChordQuality.DominantSeventhFlatFive,
    ChordQuality.MajorSeventhFlatFive,
]

let susFours = [
    ChordQuality.DominantSeventhSusFour,
    ChordQuality.MajorSeventhSusFour,
]

let tetrads = unaltered + flatFives + susFours

let unalteredPentads = tetrads.map {
    print(reflect($0).count)
}


extension String {
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}