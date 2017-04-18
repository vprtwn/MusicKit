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
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Thirteenth")
    name = name + "FlatNineSharpEleven"
    var symbol = q.description.replacingOccurrences(of: "7", with: "13")
    symbol = symbol + "♭9♯11"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNineSharpElevens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.flatNine.rawValue),
                Float(ChordExtension.sharpEleven.rawValue),
                Float(ChordExtension.thirteen.rawValue),
        ])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNineSharpElevens.1.append(intervalLine)
}

var flatNineFlatThirteens = ([String](), [String]())
for q in nonAugmentedTetrads {
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Eleventh")
    name = name + "FlatNineFlatThirteen"
    var symbol = q.description.replacingOccurrences(of: "7", with: "11")
    symbol = symbol + "♭9♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNineFlatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.flatNine.rawValue),
                Float(ChordExtension.eleven.rawValue),
                Float(ChordExtension.flatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNineFlatThirteens.1.append(intervalLine)
}

var sharpElevenFlatThirteens = ([String](), [String]())
for q in nonDiminishedAugmentedTetrads {
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Ninth")
    name = name + "SharpElevenFlatThirteen"
    var symbol = q.description.replacingOccurrences(of: "7", with: "9")
    symbol = symbol + "♯11♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    sharpElevenFlatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue),
                Float(ChordExtension.sharpEleven.rawValue),
                Float(ChordExtension.flatThirteen.rawValue)])
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
            [Float(ChordExtension.flatNine.rawValue),
                Float(ChordExtension.sharpEleven.rawValue),
                Float(ChordExtension.flatThirteen.rawValue)])
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

printCode(groupName: "flat nine sharp eleven heptads", symbols: flatNineSharpElevens.0, intervals: flatNineSharpElevens.1)
printCode(groupName: "flat nine flat thirteen heptads", symbols: flatNineFlatThirteens.0, intervals: flatNineFlatThirteens.1)
printCode(groupName: "sharp eleven flat thirteen heptads", symbols: sharpElevenFlatThirteens.0, intervals: sharpElevenFlatThirteens.1)
printCode(groupName: "flat nine sharp eleven flat thirteen heptads", symbols: flatNineSharpElevenFlatThirteens.0, intervals: flatNineSharpElevenFlatThirteens.1)
