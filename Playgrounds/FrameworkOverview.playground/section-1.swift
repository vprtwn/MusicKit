import MusicKit
// Note: to run this playground, you'll need to first build the MusicKit_OSX framework.

///# MusicKit

///### Pitch
///* `Pitch` is the basic unit of `MusicKit`. 
///* A `Pitch` can be created with a MIDI number, or with a chroma and octave number.

///```swift
let a4 = Pitch(midi: 69)
print(a4.noteName)    // A4
print(a4.frequency)   // 440.0

let ds2 = Pitch(chroma: .ds, octave: 2)
let c5 = Chroma.c*5
///```

///* Changing the value of MusicKit's concert A changes the computed frequency of all pitches.

///```swift
MusicKit.concertA = 444
print(a4.frequency)   // 444.0
MusicKit.concertA = 440
///```

///### Chroma
///* A `Pitch` has a `Chroma` if it has an integral MIDI number.

///```swift
print(a4.chroma)          // Optional(A)
let ahalfsharp = Pitch(midi: 69.5)
print(ahalfsharp.chroma)  // nil
///```

///* A `Chroma` and an octave number can be used to create a `Pitch`.

///```swift
let d5 = Pitch(chroma: .d, octave: 5)
print(d5)         // D5
///```

///* A `Chroma` can be created with an index or using one of the provided constants.
///```swift
let c = Chroma.c
print(c)          // C
let cs = Chroma.cs
print(cs)     // C♯
let d = c + 2
print(d)          // D
///```

///### PitchSet
///* A `PitchSet` is a collection of unique `Pitch` instances ordered by frequency.

///```swift
var cmaj = PitchSet(pitches: Chroma.c*2, Chroma.e*2, Chroma.g*2)
print(cmaj)       // [C2, E2, G2]

let pitches = [Chroma.fs*2, Chroma.as*2, Chroma.cs*3]
var fsmaj = PitchSet(pitches)
print(fsmaj)  // [F♯2, B♭2, C♯3]
///```

///* `PitchSet` supports many operations.
///```swift
var petrushka = cmaj + fsmaj
print(petrushka)                    // [C2, E2, F♯2, G2, B♭2, C♯3]
print(cmaj == fsmaj)        // false
print(petrushka.gamut())            // [F♯, G, B♭, C, E, C♯]
petrushka.remove(Pitch(chroma: Chroma.g, octave: 2))
print(petrushka)                    // [C2, E2, F♯2, B♭2, C♯3]
let f = Chroma.f
print(cmaj / f)                   // [F1, C2, E2, G2]
///```

///### Harmonizer
///* A `Harmonizer` is a function with the signature `(Pitch -> PitchSet)`.
///* `Scale` and `Chord` contain common scale and chord harmonizers.
///* `Major`, `Minor`, and `Harmony` can be used to create functional harmony.

///### Scale
///* `Scale` contains common scale harmonizers.

///```swift
let major = Scale.Major
print(major(a4))   // [A4, B4, C♯5, D5, E5, F♯5, G♯5]
///```

///* The `Harmony` enum provides a way to create custom harmonizers from an array of semitone intervals.

///```swift
let equidistantPentatonic = Harmony.create([2.4, 2.4, 2.4, 2.4, 2.4])
///```

///### Chord
///* `Chord` contains common chord harmonizers.

///```swift
let minor = Chord.Minor
print(minor(a4))   // [A4, C5, E5]
///```

///* `Chord` also provides a function to create a chord based on a `Harmonizer` (typically a scale).

///```swift
let chord = Chord.create(major, indices: [0, 2, 4, 6])
let ch = chord(Pitch(midi: 69))
print(ch)          // [A4, C♯5, E5, G♯5]
///```

///* `Chord.name` can be used to derive a chord name from a pitch set

///```swift
let pitchSet: PitchSet = [Chroma.b*0, Chroma.cs*2, Chroma.f*3, Chroma.g*4]
print(Chord.name(pitchSet)!)          // G7♭5/B
let descriptor = Chord.descriptor(pitchSet)
print(descriptor!)    // root: G, quality: dominant seventh flat five, bass: B
///```

///### Functional harmony
///* `Major` and `Minor` contain harmonizers for creating diatonic functional harmony.

///```swift
let neapolitan = Major.bII
print(neapolitan(Chroma.c*5))  // [C♯5, E♯5, G♯5]
let g4 = Chroma.g*4
let plagalCadence = [Major.IV, Major.I] * g4
print(plagalCadence)   // [[C5, E5, G5], [G4, B4, D5]]
///```

///* `Harmony` provides a way to create custom functional harmonizers.

///```swift
let V7ofV = HarmonicFunction.create(Scale.Major, degree: 5, chord: Major.V7)
print(V7ofV(c5))      // [D6, F♯6, A6, C7]
///```

