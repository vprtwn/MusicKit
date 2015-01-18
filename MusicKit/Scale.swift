//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// a ScaleTuple describes a scale with an array of intervals and a name
public typealias ScaleTuple = ([Float], String)

public enum Scale {

    public static func create(intervals: [Float]) -> Harmonizer {
        return { firstPitch in
            var pitchSet = PitchSet()
            pitchSet.add(firstPitch)
            var previousPitch = firstPitch
            let scaleLength = intervals.count
            var midiNum = firstPitch.midi
            for i in 1..<scaleLength {
                let prevDegree = (i-1)
                midiNum = midiNum + intervals[prevDegree]
                var pitch = Pitch(midi: midiNum)

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
                
                pitchSet.add(pitch)
                previousPitch = pitch
            }
            return pitchSet
        }
    }

    static let _Chromatic : ScaleTuple = ([1], "Chromatic")
    static let _Wholetone : ScaleTuple = ([2], "Wholetone")
    static let _Octatonic1 : ScaleTuple = ([2, 1], "Octatonic mode 1")
    static let _Octatonic2 : ScaleTuple = (_Octatonic1.0.rotate(1), "Octatonic mode 2")
    static let _Major : ScaleTuple = ([2, 2, 1, 2, 2, 2, 1], "Major")
    static let _Dorian : ScaleTuple = (_Major.0.rotate(1), "Dorian")
    static let _Phrygian : ScaleTuple = (_Major.0.rotate(2), "Phrygian")
    static let _Lydian : ScaleTuple = (_Major.0.rotate(3), "Lydian")
    static let _Mixolydian : ScaleTuple = (_Major.0.rotate(4), "Mixolydian")
    static let _Minor : ScaleTuple = (_Major.0.rotate(5), "Minor")
    static let _Locrian : ScaleTuple = (_Major.0.rotate(6), "Locrian")

    public static let Chromatic : Pitch -> PitchSet = Scale.create(_Chromatic.0)
    public static let Wholetone : Pitch -> PitchSet = Scale.create(_Wholetone.0)
    public static let Octatonic1 : Pitch -> PitchSet = Scale.create(_Octatonic1.0)
    public static let Octatonic2 : Pitch -> PitchSet = Scale.create(_Octatonic2.0)
    public static let Major : Pitch -> PitchSet = Scale.create(_Major.0)
    public static let Dorian : Pitch -> PitchSet = Scale.create(_Dorian.0)
    public static let Phrygian : Pitch -> PitchSet = Scale.create(_Phrygian.0)
    public static let Lydian : Pitch -> PitchSet = Scale.create(_Lydian.0)
    public static let Mixolydian : Pitch -> PitchSet = Scale.create(_Mixolydian.0)
    public static let Minor : Pitch -> PitchSet = Scale.create(_Minor.0)
    public static let Locrian : Pitch -> PitchSet = Scale.create(_Locrian.0)
}
