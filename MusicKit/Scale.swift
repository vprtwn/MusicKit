//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// (intervals, name)
typealias ScaleTuple = ([Float], String)

/// Phantom type containing common scale Harmonizers
public enum Scale {
    static let _Chromatic : ScaleTuple = ([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], "Chromatic")
    static let _Wholetone : ScaleTuple = ([2, 2, 2, 2, 2, 2], "Wholetone")
    static let _Octatonic1 : ScaleTuple = ([2, 1, 2, 1, 2, 1, 2], "Octatonic mode 1")
    static let _Octatonic2 : ScaleTuple = ([1, 2, 1, 2, 1, 2, 1], "Octatonic mode 2")
    static let _Major : ScaleTuple = ([2, 2, 1, 2, 2, 2], "Major")
    static let _Dorian : ScaleTuple = ([2, 1, 2, 2, 2, 1], "Dorian")
    static let _Phrygian : ScaleTuple = ([1, 2, 2, 2, 1, 2], "Phrygian")
    static let _Lydian : ScaleTuple = ([2, 2, 2, 1, 2, 2], "Lydian")
    static let _Mixolydian : ScaleTuple = ([2, 2, 1, 2, 2, 1], "Mixolydian")
    static let _Minor : ScaleTuple = ([2, 1, 2, 2, 1, 2], "Minor")
    static let _Locrian : ScaleTuple = ([1, 2, 2, 1, 2, 2], "Locrian")

    public static let Chromatic : Harmonizer = Harmony.create(_Chromatic.0)
    public static let Wholetone : Harmonizer = Harmony.create(_Wholetone.0)
    public static let Octatonic1 : Harmonizer = Harmony.create(_Octatonic1.0)
    public static let Octatonic2 : Harmonizer = Harmony.create(_Octatonic2.0)
    public static let Major : Harmonizer = Harmony.create(_Major.0)
    public static let Dorian : Harmonizer = Harmony.create(_Dorian.0)
    public static let Phrygian : Harmonizer = Harmony.create(_Phrygian.0)
    public static let Lydian : Harmonizer = Harmony.create(_Lydian.0)
    public static let Mixolydian : Harmonizer = Harmony.create(_Mixolydian.0)
    public static let Minor : Harmonizer = Harmony.create(_Minor.0)
    public static let Locrian : Harmonizer = Harmony.create(_Locrian.0)
}
