import MusicKit
// Note: to run this playground, you'll need to first build the MusicKit_OSX framework.

///# MusicKit

///### Pitch
///* `Pitch` is the basic unit of `MusicKit`. 
///* A `Pitch` can be created with a MIDI number, or with a chroma and octave number.

///```swift
let A4 = Pitch(midi: 69)
print(A4.noteName)    // A4
print(A4.frequency)   // 440.0

let DSharp2 = Pitch(chroma: .Ds, octave: 2)
let C5 = Chroma.C*5
let G4 = 🎹.G*4
///```

///* Changing the value of MusicKit's concert A changes the computed frequency of all pitches.

///```swift
MusicKit.concertA = 444
print(A4.frequency)   // 444.0
MusicKit.concertA = 440
///```

///### Chroma
///* A `Pitch` has a `Chroma` if it has an integral MIDI number.

///```swift
print(A4.chroma)          // Optional(A)
let AHalfSharp = Pitch(midi: 69.5)
print(AHalfSharp.chroma)  // nil
///```

///* A `Chroma` and an octave number can be used to create a `Pitch`.

///```swift
let D5 = Pitch(chroma: .D, octave: 5)
print(D5)         // D5
///```

///* A `Chroma` can be created with an index or using one of the provided constants.
///```swift
let C = Chroma.C
print(C)          // C
let CSharp = Chroma.Cs
print(CSharp)     // C♯
let D = C + 2
print(D)          // D
///```

///### PitchSet
///* A `PitchSet` is a collection of unique `Pitch` instances ordered by frequency.

///```swift
var CMajor = PitchSet(pitches: Chroma.C*2, Chroma.E*2, Chroma.G*2)
print(CMajor)       // [C2, E2, G2]

let pitches = [Chroma.Fs*2, Chroma.As*2, Chroma.Cs*3]
var FSharpMajor = PitchSet(pitches)
print(FSharpMajor)  // [F♯2, B♭2, C♯3]
///```

///* `PitchSet` supports many operations.
///```swift
var petrushka = CMajor + FSharpMajor
print(petrushka)                    // [C2, E2, F♯2, G2, B♭2, C♯3]
print(CMajor == FSharpMajor)        // false
print(petrushka.gamut())            // [F♯, G, B♭, C, E, C♯]
petrushka.remove(Pitch(chroma: Chroma.G, octave: 2))
print(petrushka)                    // [C2, E2, F♯2, B♭2, C♯3]
let F = Chroma.F
print(CMajor / F)                   // [F1, C2, E2, G2]
///```

///### Harmonizer
///* A `Harmonizer` is a function with the signature `(Pitch -> PitchSet)`.
///* `Scale` and `Chord` contain common scale and chord harmonizers.
///* `Major`, `Minor`, and `Harmony` can be used to create functional harmony.

///### Scale
///* `Scale` contains common scale harmonizers.

///```swift
let major = Scale.Major
print(major(A4))   // [A4, B4, C♯5, D5, E5, F♯5, G♯5]
///```

///* The `Scale` enum also provides a way to create a custom scale from an array of semitone intervals.

///```swift
let equidistantPentatonic = Scale.create([2.4, 2.4, 2.4, 2.4, 2.4])
///```

///### Chord
///* `Chord` contains common chord harmonizers.
///* Chords are in root position by default. You may also specify the inversion and any additions.

///```swift
let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(A4))   // [C5, E5, A5, B5]
///```

///* `Chord` also provides a function to create a chord based on a `Harmonizer` (typically a scale).

///```swift
let chord = Chord.create(major, indices: [0, 2, 4, 6])
let ch = chord(Pitch(midi: 69))
print(ch)          // [A4, C♯5, E5, G♯5]
///```

///### Functional harmony
///* `Major` and `Minor` contain harmonizers for creating diatonic functional harmony.

///```swift
let neapolitan = Major.bII
print(neapolitan(Chroma.C*5))  // [C♯5, E♯5, G♯5]
let G4 = Chroma.G*4
let plagalCadence = [Major.IV, Major.I] * G4
print(plagalCadence)   // [[F5, A5, C6], [C5, E5, G5]]
///```

///* `Harmony` provides a way to create custom functional harmonizers.

///```swift
let V7ofV = HarmonicFunction.create(Scale.Major, degree: 5, chord: Major.V7)
print(V7ofV(C5))      // [D6, F♯6, A6, C7]
///```

