//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct Scale : Printable {
    public let intervals : [Float]
    public let name : String

    public init(intervals: [Float], name: String = "") {
        self.intervals = intervals
        self.name = name
    }

    public var description : String {
        return "\(name)"
    }

    public static let Chromatic = Scale(intervals: [1],
        name: "Chromatic")
    public static let Wholetone = Scale(intervals: [2],
        name: "Wholetone")
    public static let Octatonic1 = Scale(intervals: [2, 1],
        name: "Octatonic mode 1")
    public static let Octatonic2 = Scale(intervals: Octatonic1.intervals.rotate(1),
        name: "Octatonic mode 2")
    public static let Major = Scale(intervals: [2, 2, 1, 2, 2, 2, 1],
        name: "Major")
    public static let Dorian = Scale(intervals: Major.intervals.rotate(1),
        name: "Dorian")
    public static let Phrygian = Scale(intervals: Major.intervals.rotate(2),
        name: "Phrygian")
    public static let Lydian = Scale(intervals: Major.intervals.rotate(3),
        name: "Lydian")
    public static let Mixolydian = Scale(intervals: Major.intervals.rotate(4),
        name: "Mixolydian")
    public static let Minor = Scale(intervals: Major.intervals.rotate(5),
        name: "Minor")
    public static let Locrian = Scale(intervals: Major.intervals.rotate(6),
        name: "Locrian")
}
