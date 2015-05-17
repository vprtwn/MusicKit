import MusicKit

let unalteredTetrads = ChordQuality.UnalteredTetrads

var unalteredPentadSymbols = [String]()
var unalteredPentadIntervals = [String]()
var unalteredHexadSymbols = [String]()
var unalteredHexadIntervals = [String]()
var unalteredHeptadSymbols = [String]()
var unalteredHeptadIntervals = [String]()
for q in unalteredTetrads {
    // pentad symbols
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Ninth")
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "9")
    var symbolLine = "case \(name) = \"\(symbol)\""
    unalteredPentadSymbols.append(symbolLine)

    // pentad intervals
    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    unalteredPentadIntervals.append(intervalLine)

    // hexad symbols
    name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Eleventh")
    symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "11")
    symbolLine = "case \(name) = \"\(symbol)\""
    unalteredHexadSymbols.append(symbolLine)

    // hexad intervals
    intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue),
                Float(ChordExtension.Eleven.rawValue)])
    intIntervals.removeAll()
    for i in intervals { intIntervals.append(Int(i)) }
    intervalLine = "case \(name): return \(intIntervals)"
    unalteredHexadIntervals.append(intervalLine)

    // heptad symbols
    name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Thirteenth")
    symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "13")
    symbolLine = "case \(name) = \"\(symbol)\""
    unalteredHeptadSymbols.append(symbolLine)

    // heptad intervals
    intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue),
                Float(ChordExtension.Eleven.rawValue),
                Float(ChordExtension.Thirteen.rawValue)])
    intIntervals.removeAll()
    for i in intervals { intIntervals.append(Int(i)) }
    intervalLine = "case \(name): return \(intIntervals)"
    unalteredHeptadIntervals.append(intervalLine)
}

func printCode(groupName: String, symbols: [String], intervals: [String]) {
    print("// \(groupName)\n")
    symbols.map { print("\($0)\n") }
    print("\n")
    print("// \(groupName)\n")
    intervals.map { print("\($0)\n") }
    print("\n")
}

printCode("unaltered pentads", unalteredPentadSymbols, unalteredPentadIntervals)
printCode("unaltered hexads", unalteredHexadSymbols, unalteredHexadIntervals)
printCode("unaltered heptads", unalteredHeptadSymbols, unalteredHeptadIntervals)
