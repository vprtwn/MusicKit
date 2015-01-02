//  Copyright (c) 2015 Ben Guo. All rights reserved.

public struct Scale {
    public let intervals : [Float]

    public init!(intervals: [Float]) {
        let sum = intervals.reduce(0, combine: +)
        if sum%12 != 0 {
            return nil
        }
        self.intervals = intervals
    }

    /// Returns the number of semitones between the first note of the scale and the given scale index
    func semitones(index: Int) -> Float {
        let scaleLength = self.intervals.count
        let octaves = Int(index/scaleLength)
        let indexRemainder = index%scaleLength
        let semitoneRemainder = self.intervals[0..<indexRemainder].reduce(0.0, combine: +)
        return Float(octaves)*12.0 + semitoneRemainder
    }

    public static let Chromatic = Scale(intervals: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
    public static let Octatonic1 = Scale(intervals: [2, 1, 2, 1, 2, 1, 2, 1])
    public static let Octatonic2 = Scale(intervals: Octatonic1!.intervals.rotate(1))
    public static let Major = Scale(intervals: [2, 2, 1, 2, 2, 2, 1])
    public static let Dorian = Scale(intervals: Major.intervals.rotate(1))
    public static let Phrygian = Scale(intervals: Major.intervals.rotate(2))
    public static let Lydian = Scale(intervals: Major.intervals.rotate(3))
    public static let Mixolydian = Scale(intervals: Major.intervals.rotate(4))
    public static let Minor = Scale(intervals: Major.intervals.rotate(5))
    public static let Locrian = Scale(intervals: Major.intervals.rotate(6))
}

public struct ScaleCollection : CollectionType {
    public let firstPitch : Pitch
    public let scale : Scale
    public let startIndex : Int = 0
    public let endIndex : Int

    public init(firstPitch: Pitch, scale: Scale, end: Int) {
        self.firstPitch = firstPitch
        self.scale = scale
        self.endIndex = end
    }

    public func generate() -> GeneratorOf<Pitch> {
        var midiNum = firstPitch.midiNumber + Int(scale.semitones(startIndex))
        var scaleLength = scale.intervals.count
        var index = startIndex
        var degree = index%scaleLength
        return GeneratorOf<Pitch> {
            if index < self.endIndex {
                let pitch = Pitch(midiNumber: midiNum)
                midiNum = midiNum + Int(self.scale.intervals[degree])
                degree = (++index)%scaleLength
                return pitch
            }
            else {
                return nil
            }
        }
    }

    public subscript(i: Int) -> Pitch {
        let midiNum = firstPitch.midiNumber + Int(scale.semitones(startIndex + i))
        return Pitch(midiNumber: midiNum)
    }
}
