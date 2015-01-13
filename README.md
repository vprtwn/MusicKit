# MusicKit

Work in progress. Open `MusicKit.xcworkspace` to try the included playground.

##### Create a `Pitch` using either a MIDI number or a frequency
```Swift
let p1 = Pitch(midiNumber: 69)
println(p1.pitchClass)                   // A♮
println(p1.noteName)                     // A4
println(p1.frequency)                    // 440.0
```

##### A `PitchSet` is an ordered collection of `Pitch`es
```Swift
var ps = PitchSet()
ps.add(Pitch(midiNumber: 40))
ps.add(Pitch(midiNumber: 42))
print(ps)                                // [E2, F♯2]
```

##### Scales and chords are functions of the form `(Pitch -> PitchSet)`
```Swift
let major = Scale.Major
print(major(Pitch(midiNumber: 69)))      // [A4, B4, C♯5, D5, E5, F♯5, G♯5]

let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(Pitch(midiNumber: 69)))      // [C5, E5, A5, B5]
```

##### Chords can be created from scales
```Swift
let chord = Chord.create(Scale.Major, indices: [0, 2, 4, 6])
print(chord(Pitch(midiNumber: 69)))      // [A4, C♯5, E5, G♯5]
```