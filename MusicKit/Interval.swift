//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Phantom type containing interval harmonizers
public enum Interval {
    public static let Unison = Harmony.create([Float(IntervalQuality.unison.rawValue)])
    public static let MinorSecond = Harmony.create([Float(IntervalQuality.minorSecond.rawValue)])
    public static let MajorSecond = Harmony.create([Float(IntervalQuality.majorSecond.rawValue)])
    public static let MinorThird = Harmony.create([Float(IntervalQuality.minorThird.rawValue)])
    public static let MajorThird = Harmony.create([Float(IntervalQuality.majorThird.rawValue)])
    public static let PerfectFourth = Harmony.create([Float(IntervalQuality.perfectFourth.rawValue)])
    public static let Tritone = Harmony.create([Float(IntervalQuality.tritone.rawValue)])
    public static let PerfectFifth = Harmony.create([Float(IntervalQuality.perfectFifth.rawValue)])
    public static let MinorSixth = Harmony.create([Float(IntervalQuality.minorSixth.rawValue)])
    public static let MajorSixth = Harmony.create([Float(IntervalQuality.majorSixth.rawValue)])
    public static let MinorSeventh = Harmony.create([Float(IntervalQuality.minorSeventh.rawValue)])
    public static let MajorSeventh = Harmony.create([Float(IntervalQuality.majorSeventh.rawValue)])
    public static let Octave = Harmony.create([Float(IntervalQuality.octave.rawValue)])
    public static let MinorNinth = Harmony.create([Float(IntervalQuality.minorNinth.rawValue)])
    public static let MajorNinth = Harmony.create([Float(IntervalQuality.majorNinth.rawValue)])
    public static let MinorTenth = Harmony.create([Float(IntervalQuality.minorTenth.rawValue)])
    public static let MajorTenth = Harmony.create([Float(IntervalQuality.majorTenth.rawValue)])
    public static let PerfectEleventh = Harmony.create([Float(IntervalQuality.perfectEleventh.rawValue)])
    public static let Tritave = Harmony.create([Float(IntervalQuality.tritave.rawValue)])
    public static let PerfectTwelfth = Harmony.create([Float(IntervalQuality.perfectTwelfth.rawValue)])
    public static let MinorThirteenth = Harmony.create([Float(IntervalQuality.minorThirteenth.rawValue)])
    public static let MajorThirteenth = Harmony.create([Float(IntervalQuality.majorThirteenth.rawValue)])
    public static let MinorFourteenth = Harmony.create([Float(IntervalQuality.minorFourteenth.rawValue)])
    public static let MajorFourteenth = Harmony.create([Float(IntervalQuality.majorFourteenth.rawValue)])
}
