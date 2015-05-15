//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

/// Phantom type containing interval harmonizers
public enum Interval {
    public static let Unison = Harmony.create([Float(IntervalQuality.Unison.rawValue)])
    public static let MinorSecond = Harmony.create([Float(IntervalQuality.MinorSecond.rawValue)])
    public static let MajorSecond = Harmony.create([Float(IntervalQuality.MajorSecond.rawValue)])
    public static let MinorThird = Harmony.create([Float(IntervalQuality.MinorThird.rawValue)])
    public static let MajorThird = Harmony.create([Float(IntervalQuality.MajorThird.rawValue)])
    public static let PerfectFourth = Harmony.create([Float(IntervalQuality.PerfectFourth.rawValue)])
    public static let Tritone = Harmony.create([Float(IntervalQuality.Tritone.rawValue)])
    public static let PerfectFifth = Harmony.create([Float(IntervalQuality.PerfectFifth.rawValue)])
    public static let MinorSixth = Harmony.create([Float(IntervalQuality.MinorSixth.rawValue)])
    public static let MajorSixth = Harmony.create([Float(IntervalQuality.MajorSixth.rawValue)])
    public static let MinorSeventh = Harmony.create([Float(IntervalQuality.MinorSeventh.rawValue)])
    public static let MajorSeventh = Harmony.create([Float(IntervalQuality.MajorSeventh.rawValue)])
    public static let Octave = Harmony.create([Float(IntervalQuality.Octave.rawValue)])
    public static let MinorNinth = Harmony.create([Float(IntervalQuality.MinorNinth.rawValue)])
    public static let MajorNinth = Harmony.create([Float(IntervalQuality.MajorNinth.rawValue)])
    public static let MinorTenth = Harmony.create([Float(IntervalQuality.MinorTenth.rawValue)])
    public static let MajorTenth = Harmony.create([Float(IntervalQuality.MajorTenth.rawValue)])
    public static let PerfectEleventh = Harmony.create([Float(IntervalQuality.PerfectEleventh.rawValue)])
    public static let Tritave = Harmony.create([Float(IntervalQuality.Tritave.rawValue)])
    public static let PerfectTwelfth = Harmony.create([Float(IntervalQuality.PerfectTwelfth.rawValue)])
    public static let MinorThirteenth = Harmony.create([Float(IntervalQuality.MinorThirteenth.rawValue)])
    public static let MajorThirteenth = Harmony.create([Float(IntervalQuality.MajorThirteenth.rawValue)])
    public static let MinorFourteenth = Harmony.create([Float(IntervalQuality.MinorFourteenth.rawValue)])
    public static let MajorFourteenth = Harmony.create([Float(IntervalQuality.MajorFourteenth.rawValue)])
}
