//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// a ScaleTuple describes a scale with an array of intervals and a name
public typealias ScaleTuple = ([Float], String)

public enum Scale {

    public static func PitchToPitchSet(intervals: [Float]) -> (Pitch -> PitchSet) {
        return { firstPitch in
            var pitches : [Pitch] = []
            pitches.append(firstPitch)
            var previousPitch = firstPitch
            let scaleLength = intervals.count
            var midiNum = firstPitch.midiNumber
            for var i=1; i<scaleLength; i++ {
                let prevDegree = (i-1)
                midiNum = midiNum + intervals[prevDegree]
                var pitch = Pitch(midiNumber: midiNum)

                // if the scale is diatonic and the current and previous pitch
                /// have names, set a preferred pitch class name
                if scaleLength == 7 {
                    if let pitchClass = pitch.pitchClass {
                        if let previousPitchName = previousPitch.noteNameTuple {
                            let preferredLetterName = previousPitchName.0.next()
                            let preferredPitchName = pitchClass.names.filter {
                                n in n.0 == preferredLetterName
                                }.first
                            pitch.preferredName = preferredPitchName
                        }
                    }
                }
                
                pitches.append(pitch)
                previousPitch = pitch
            }
            return PitchSet()
        }
    }

    public static let Chromatic : ScaleTuple = ([1], "Chromatic")
    public static let Wholetone : ScaleTuple = ([2], "Wholetone")
    public static let Octatonic1 : ScaleTuple = ([2, 1], "Octatonic mode 1")
    public static let Octatonic2 : ScaleTuple = (Octatonic1.0.rotate(1), "Octatonic mode 2")
    public static let Major : ScaleTuple = ([2, 2, 1, 2, 2, 2, 1], "Major")
    public static let Dorian : ScaleTuple = (Major.0.rotate(1), "Dorian")
    public static let Phrygian : ScaleTuple = (Major.0.rotate(2), "Phrygian")
    public static let Lydian : ScaleTuple = (Major.0.rotate(3), "Lydian")
    public static let Mixolydian : ScaleTuple = (Major.0.rotate(4), "Mixolydian")
    public static let Minor : ScaleTuple = (Major.0.rotate(5), "Minor")
    public static let Locrian : ScaleTuple = (Major.0.rotate(6), "Locrian")

    public static func Chromatic(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Chromatic.0)(pitch) }
    public static func Wholetone(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Wholetone.0)(pitch) }
    public static func Octatonic1(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Octatonic1.0)(pitch) }
    public static func Octatonic2(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Octatonic2.0)(pitch) }
    public static func Major(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Major.0)(pitch) }
    public static func Dorian(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Dorian.0)(pitch) }
    public static func Phrygian(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Phrygian.0)(pitch) }
    public static func Lydian(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Lydian.0)(pitch) }
    public static func Mixolydian(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Mixolydian.0)(pitch) }
    public static func Minor(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Minor.0)(pitch) }
    public static func Locrian(pitch: Pitch) -> PitchSet { return PitchToPitchSet(Locrian.0)(pitch) }
}
