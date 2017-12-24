//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Phantom type containing common scale Harmonizers
public enum Scale {
    public static let Chromatic = Harmony.create(ScaleQuality.Chromatic.intervals)
    public static let Wholetone = Harmony.create(ScaleQuality.Wholetone.intervals)
    public static let Octatonic1 = Harmony.create(ScaleQuality.Octatonic1.intervals)
    public static let Octatonic2 = Harmony.create(ScaleQuality.Octatonic2.intervals)
    public static let Major = Harmony.create(ScaleQuality.Major.intervals)
    public static let Dorian = Harmony.create(ScaleQuality.Dorian.intervals)
    public static let Phrygian = Harmony.create(ScaleQuality.Phrygian.intervals)
    public static let Lydian = Harmony.create(ScaleQuality.Lydian.intervals)
    public static let Mixolydian = Harmony.create(ScaleQuality.Mixolydian.intervals)
    public static let Minor = Harmony.create(ScaleQuality.Minor.intervals)
    public static let Locrian = Harmony.create(ScaleQuality.Locrian.intervals)
}
