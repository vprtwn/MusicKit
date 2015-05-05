//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// (intervals, name)
typealias ScaleTuple = ([Float], String)

/// Phantom type containing functions for creating scale Harmonizers
public enum Scale {

    public static func create(intervals: [Float]) -> Harmonizer {
        return { firstPitch in
            var pitchSet = PitchSet()
            pitchSet.insert(firstPitch)
            var previousPitch = firstPitch
            let scaleLength = intervals.count
            var midiNum = firstPitch.midi
            for i in 1..<scaleLength {
                let prevDegree = (i-1)
                midiNum = midiNum + intervals[prevDegree]
                var pitch = Pitch(midi: midiNum)
                pitchSet.insert(pitch)
                previousPitch = pitch
            }
            return pitchSet
        }
    }

    static let _Chromatic : ScaleTuple = ([1], "Chromatic")
    static let _Wholetone : ScaleTuple = ([2], "Wholetone")
    static let _Octatonic1 : ScaleTuple = ([2, 1], "Octatonic mode 1")
    static let _Octatonic2 : ScaleTuple = (MKUtil.rotate(_Octatonic1.0, 1), "Octatonic mode 2")
    static let _Major : ScaleTuple = ([2, 2, 1, 2, 2, 2, 1], "Major")
    static let _Dorian : ScaleTuple = (MKUtil.rotate(_Major.0, 1), "Dorian")
    static let _Phrygian : ScaleTuple = (MKUtil.rotate(_Major.0, 2), "Phrygian")
    static let _Lydian : ScaleTuple = (MKUtil.rotate(_Major.0, 3), "Lydian")
    static let _Mixolydian : ScaleTuple = (MKUtil.rotate(_Major.0, 4), "Mixolydian")
    static let _Minor : ScaleTuple = (MKUtil.rotate(_Major.0, 5), "Minor")
    static let _Locrian : ScaleTuple = (MKUtil.rotate(_Major.0, 6), "Locrian")

    public static let Chromatic : Harmonizer = Scale.create(_Chromatic.0)
    public static let Wholetone : Harmonizer = Scale.create(_Wholetone.0)
    public static let Octatonic1 : Harmonizer = Scale.create(_Octatonic1.0)
    public static let Octatonic2 : Harmonizer = Scale.create(_Octatonic2.0)
    public static let Major : Harmonizer = Scale.create(_Major.0)
    public static let Dorian : Harmonizer = Scale.create(_Dorian.0)
    public static let Phrygian : Harmonizer = Scale.create(_Phrygian.0)
    public static let Lydian : Harmonizer = Scale.create(_Lydian.0)
    public static let Mixolydian : Harmonizer = Scale.create(_Mixolydian.0)
    public static let Minor : Harmonizer = Scale.create(_Minor.0)
    public static let Locrian : Harmonizer = Scale.create(_Locrian.0)
}
