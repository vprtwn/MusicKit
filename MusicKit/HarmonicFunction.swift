//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum HarmonicFunction {
    /// Creates a harmonizer that applies a chord to a scale at a (1-indexed) scale degree.
    /// Note that non-integral scale degrees may be used to specify non-scale tones.
    /// A negative degree will be transposed by octave until it is non-negative.
    public static func create(_ scale: @escaping Harmonizer, degree: Float, chord: @escaping Harmonizer) -> Harmonizer {
        return { pitch in
            var zDegree = degree - 1 // 0-indexed degree
            while zDegree < 0 {
                zDegree = zDegree + 12
            }
            let scalePitchSet = scale(pitch)
            let scaleCount = Int(scalePitchSet.count)
            let floorDegree = Int(floorf(zDegree)) % scaleCount
            let floorPitch = scalePitchSet[floorDegree]
            let degreeIsNonIntegral = zDegree - Float(floorDegree) != 0;
            if (degreeIsNonIntegral) {
                let ceilDegree = Int(ceilf(zDegree)) % scaleCount
                var ceilPitch = scalePitchSet[ceilDegree]
                while (ceilPitch < floorPitch) {
                    ceilPitch = Pitch(midi: ceilPitch.midi + 12)
                }
                let midiDelta = ceilPitch.midi - floorPitch.midi
                let fractionalDegree = zDegree - Float(floorDegree)
                let midi = floorPitch.midi + (midiDelta * fractionalDegree)
                return chord(Pitch(midi: midi))
            }
            else {
                return chord(floorPitch)
            }
        }
    }

    // Augmented sixth chords
    static let It6 = Harmony.create([4, 6])
    static let Fr6 = Harmony.create([4, 2, 4])
    static let Ger6 = Chord.DominantSeventh
}

public enum Major {
    public static let I = HarmonicFunction.create(Scale.Major, degree: 1, chord: Chord.Major)
    public static let bII = HarmonicFunction.create(Scale.Major, degree: 1.5, chord: Chord.Major)
    public static let ii = HarmonicFunction.create(Scale.Major, degree: 2, chord: Chord.Minor)
    public static let iii = HarmonicFunction.create(Scale.Major, degree: 3, chord: Chord.Minor)
    public static let IV = HarmonicFunction.create(Scale.Major, degree: 4, chord: Chord.Major)
    public static let V = HarmonicFunction.create(Scale.Major, degree: 5, chord: Chord.Major)
    public static let V7 = HarmonicFunction.create(Scale.Major, degree: 5, chord: Chord.DominantSeventh)
    public static let It6 = HarmonicFunction.create(Scale.Major, degree: 5.5, chord: HarmonicFunction.It6)
    public static let Fr6 = HarmonicFunction.create(Scale.Major, degree: 5.5, chord: HarmonicFunction.Fr6)
    public static let Ger6 = HarmonicFunction.create(Scale.Major, degree: 5.5, chord: HarmonicFunction.Ger6)
    public static let vi = HarmonicFunction.create(Scale.Major, degree: 6, chord: Chord.Minor)
    public static let viio = HarmonicFunction.create(Scale.Major, degree: 7, chord: Chord.Diminished)
}

public enum Minor {
    public static let i = HarmonicFunction.create(Scale.Minor, degree: 1, chord: Chord.Minor)
    public static let bII = HarmonicFunction.create(Scale.Minor, degree: 1.5, chord: Chord.Major)
    public static let iio = HarmonicFunction.create(Scale.Minor, degree: 2, chord: Chord.Diminished)
    public static let III = HarmonicFunction.create(Scale.Minor, degree: 3, chord: Chord.Major)
    public static let iv = HarmonicFunction.create(Scale.Minor, degree: 4, chord: Chord.Minor)
    public static let v = HarmonicFunction.create(Scale.Minor, degree: 5, chord: Chord.Minor)
    public static let V = HarmonicFunction.create(Scale.Minor, degree: 5, chord: Chord.Major)
    public static let V7 = HarmonicFunction.create(Scale.Minor, degree: 5, chord: Chord.DominantSeventh)
    public static let It6 = HarmonicFunction.create(Scale.Minor, degree: 5.5, chord: HarmonicFunction.It6)
    public static let Fr6 = HarmonicFunction.create(Scale.Minor, degree: 5.5, chord: HarmonicFunction.Fr6)
    public static let Ger6 = HarmonicFunction.create(Scale.Minor, degree: 5.5, chord: HarmonicFunction.Ger6)
    public static let VI = HarmonicFunction.create(Scale.Minor, degree: 6, chord: Chord.Major)
    public static let VII = HarmonicFunction.create(Scale.Minor, degree: 7, chord: Chord.Major)
}
