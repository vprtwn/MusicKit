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

    static func pitchSetWithScale(scale: () -> ([Float], String), pitch: Pitch) -> PitchSet {
        return PitchSet()
    }

    public static func Chromatic() -> ([Float], String) {
        return ([1], "Chromatic")
    }

    public static func Chromatic(pitch: Pitch) -> PitchSet {
        return pitchSetWithScale(Chromatic, pitch: pitch)
    }

    public static func Wholetone() -> ([Float], String) {
        return ([2], "Wholetone")
    }

    public static func Octatonic1() -> ([Float], String) {
        return ([2, 1], "Octatonic mode 1")
    }

    public static func Octatonic2() -> ([Float], String) {
        return (Octatonic1().0.rotate(1), "Octatonic mode 2")
    }

    public static func Major() -> ([Float], String) {
        return ([2, 2, 1, 2, 2, 2, 1], "Major")
    }

    public static func Dorian() -> ([Float], String) {
        return (Major().0.rotate(1), "Dorian")
    }

    public static func Phrygian() -> ([Float], String) {
        return (Major().0.rotate(2), "Phrygian")
    }

    public static func Lydian() -> ([Float], String) {
        return (Major().0.rotate(3), "Lydian")
    }

    public static func Mixolydian() -> ([Float], String) {
        return (Major().0.rotate(4), "Mixolydian")
    }

    public static func Minor() -> ([Float], String) {
        return (Major().0.rotate(5), "Minor")
    }

    public static func Locrian() -> ([Float], String) {
        return (Major().0.rotate(6), "Locrian")
    }
}
