//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Phantom type containing common scale Harmonizers
public enum Scale {
    public static let Chromatic : Harmonizer = Harmony.create(ScaleQuality.Chromatic.intervals)
    public static let Wholetone : Harmonizer = Harmony.create(ScaleQuality.Wholetone.intervals)
    public static let Octatonic1 : Harmonizer = Harmony.create(ScaleQuality.Octatonic1.intervals)
    public static let Octatonic2 : Harmonizer = Harmony.create(ScaleQuality.Octatonic2.intervals)
    public static let Major : Harmonizer = Harmony.create(ScaleQuality.Major.intervals)
    public static let Dorian : Harmonizer = Harmony.create(ScaleQuality.Dorian.intervals)
    public static let Phrygian : Harmonizer = Harmony.create(ScaleQuality.Phrygian.intervals)
    public static let Lydian : Harmonizer = Harmony.create(ScaleQuality.Lydian.intervals)
    public static let Mixolydian : Harmonizer = Harmony.create(ScaleQuality.Mixolydian.intervals)
    public static let Minor : Harmonizer = Harmony.create(ScaleQuality.Minor.intervals)
    public static let Locrian : Harmonizer = Harmony.create(ScaleQuality.Locrian.intervals)
}
