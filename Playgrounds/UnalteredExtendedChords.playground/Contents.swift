import MusicKit

let unalteredTetrads = ChordQuality.UnalteredTetrads

// (symbols, intervals)
var unalteredPentads = ([String](), [String]())
var unalteredHexads = ([String](), [String]())
var unalteredHeptads = ([String](), [String]())
for q in unalteredTetrads {
    // pentad symbols
    var name = q.name.replacingOccurrences(of: "Seventh", with: "Ninth")
    var symbol = q.description.replacingOccurrences(of: "7", with: "9")
    var symbolLine = "case \(name) = \"\(symbol)\""
    unalteredPentads.0.append(symbolLine)

    // pentad intervals
    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    unalteredPentads.1.append(intervalLine)

    // hexad symbols

    name = q.name.replacingOccurrences(of: "Seventh", with: "Eleventh")
    symbol = q.description.replacingOccurrences(of: "7", with: "11")
    symbolLine = "case \(name) = \"\(symbol)\""
    unalteredHexads.0.append(symbolLine)

    // hexad intervals
    intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue),
                Float(ChordExtension.eleven.rawValue)])
    intIntervals.removeAll()
    for i in intervals { intIntervals.append(Int(i)) }
    intervalLine = "case \(name): return \(intIntervals)"
    unalteredHexads.1.append(intervalLine)

    // heptad symbols
    name = q.name.replacingOccurrences(of: "Seventh", with: "Thirteenth")
    symbol = q.description.replacingOccurrences(of: "7", with: "13")
    symbolLine = "case \(name) = \"\(symbol)\""
    unalteredHeptads.0.append(symbolLine)

    // heptad intervals
    intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.nine.rawValue),
                Float(ChordExtension.eleven.rawValue),
                Float(ChordExtension.thirteen.rawValue)])
    intIntervals.removeAll()
    for i in intervals { intIntervals.append(Int(i)) }
    intervalLine = "case \(name): return \(intIntervals)"
    unalteredHeptads.1.append(intervalLine)
}

func printCode(groupName: String, symbols: [String], intervals: [String]) {
    print("// \(groupName)\n")
    symbols.map { print("\($0)\n") }
    print("\n")
    print("// \(groupName)\n")
    intervals.map { print("\($0)\n") }
    print("\n")
}

printCode(groupName: "unaltered pentads", symbols: unalteredPentads.0, intervals: unalteredPentads.1)
printCode(groupName: "unaltered hexads", symbols: unalteredHexads.0, intervals: unalteredHexads.1)
printCode(groupName: "unaltered heptads", symbols: unalteredHeptads.0, intervals: unalteredHeptads.1)
