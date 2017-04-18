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

var flatNines = ([String](), [String]())
for q in unalteredTetrads {
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Thirteenth")
    name = name + "FlatNine"
    var symbol = q.description.replacingOccurrences(of: "7", with: "13")
    symbol = symbol + "♭9"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNines.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.flatNine.rawValue),
                Float(ChordExtension.eleven.rawValue),
                Float(ChordExtension.thirteen.rawValue),
        ])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNines.1.append(intervalLine)
}

var sharpElevens = ([String](), [String]())
for q in nonDiminishedTetrads {
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Thirteenth")
    name = name + "SharpEleven"
    var symbol = q.description.replacingOccurrences(of: "7", with: "13")
    symbol = symbol + "♯11"
    var symbolLine = "case \(name) = \"\(symbol)\""
    sharpElevens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue),
                Float(ChordExtension.sharpEleven.rawValue),
                Float(ChordExtension.thirteen.rawValue),
        ])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    sharpElevens.1.append(intervalLine)
}

var flatThirteens = ([String](), [String]())
for q in nonAugmentedTetrads {
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Eleventh")
    name = name + "FlatThirteen"
    var symbol = q.description.replacingOccurrences(of: "7", with: "11")
    symbol = symbol + "♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue),
                Float(ChordExtension.eleven.rawValue),
                Float(ChordExtension.flatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatThirteens.1.append(intervalLine)
}

func printCode(groupName: String, symbols: [String], intervals: [String]) {
    print("// \(groupName)\n")
    symbols.map { print("\($0)\n") }
    print("\n")
    print("// \(groupName)\n")
    intervals.map { print("\($0)\n") }
    print("\n")
}

printCode(groupName: "flat nine heptads", symbols: flatNines.0, intervals: flatNines.1)
printCode(groupName: "sharp eleven heptads", symbols: sharpElevens.0, intervals: sharpElevens.1)
printCode(groupName: "flat thirteen heptads", symbols: flatThirteens.0, intervals: flatThirteens.1)
