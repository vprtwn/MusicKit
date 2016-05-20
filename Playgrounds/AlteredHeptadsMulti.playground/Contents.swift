import MusicKit

let unalteredTetrads = ChordQuality.UnalteredTetrads
let diminishedTetrads = [ChordQuality.DiminishedSeventh, ChordQuality.HalfDiminishedSeventh]
let augmentedTetrads = [ChordQuality.AugmentedSeventh, ChordQuality.AugmentedMajorSeventh]
var nonDiminishedTetrads = unalteredTetrads.filter {
    !diminishedTetrads.contains($0)
}
var nonAugmentedTetrads = unalteredTetrads.filter {
    !augmentedTetrads.contains($0)
}
var nonDiminishedAugmentedTetrads = unalteredTetrads.filter {
    !(diminishedTetrads + augmentedTetrads).contains($0)
}

var flatNineSharpElevens = ([String](), [String]())
for q in nonDiminishedTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Thirteenth")
    name = name + "FlatNineSharpEleven"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "13")
    symbol = symbol + "♭9♯11"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNineSharpElevens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.FlatNine.rawValue),
                Float(ChordExtension.SharpEleven.rawValue),
                Float(ChordExtension.Thirteen.rawValue),
        ])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNineSharpElevens.1.append(intervalLine)
}

var flatNineFlatThirteens = ([String](), [String]())
for q in nonAugmentedTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Eleventh")
    name = name + "FlatNineFlatThirteen"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "11")
    symbol = symbol + "♭9♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNineFlatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.FlatNine.rawValue),
                Float(ChordExtension.Eleven.rawValue),
                Float(ChordExtension.FlatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNineFlatThirteens.1.append(intervalLine)
}

var sharpElevenFlatThirteens = ([String](), [String]())
for q in nonDiminishedAugmentedTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Ninth")
    name = name + "SharpElevenFlatThirteen"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "9")
    symbol = symbol + "♯11♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    sharpElevenFlatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue),
                Float(ChordExtension.SharpEleven.rawValue),
                Float(ChordExtension.FlatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    sharpElevenFlatThirteens.1.append(intervalLine)
}

var flatNineSharpElevenFlatThirteens = ([String](), [String]())
for q in nonDiminishedAugmentedTetrads {
    var name = q.name + "FlatNineSharpElevenFlatThirteen"
    var symbol = q.description + "♭9♯11♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNineSharpElevenFlatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.FlatNine.rawValue),
                Float(ChordExtension.SharpEleven.rawValue),
                Float(ChordExtension.FlatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNineSharpElevenFlatThirteens.1.append(intervalLine)
}

func printCode(groupName: String, symbols: [String], intervals: [String]) {
    print("// \(groupName)\n")
    symbols.map { print("\($0)\n") }
    print("\n")
    print("// \(groupName)\n")
    intervals.map { print("\($0)\n") }
    print("\n")
}

printCode("flat nine sharp eleven heptads", symbols: flatNineSharpElevens.0, intervals: flatNineSharpElevens.1)
printCode("flat nine flat thirteen heptads", symbols: flatNineFlatThirteens.0, intervals: flatNineFlatThirteens.1)
printCode("sharp eleven flat thirteen heptads", symbols: sharpElevenFlatThirteens.0, intervals: sharpElevenFlatThirteens.1)
printCode("flat nine sharp eleven flat thirteen heptads", symbols: flatNineSharpElevenFlatThirteens.0, intervals: flatNineSharpElevenFlatThirteens.1)
