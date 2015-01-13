# MusicKit

Work in progress. Open `MusicKit.xcworkspace` to try the included playground.

##### A `Pitch` can be initialized with a MIDI number
```Swift
let A4 = Pitch(midiNumber: 69)
println(A4.pitchClass)                   // A♮
println(A4.noteName)                     // A4
println(A4.frequency)                    // 440.0
```

##### A `PitchSet` is an ordered collection of pitches
```Swift
var ps = PitchSet()
ps.add(Pitch(midiNumber: 69))
ps.add(Pitch(midiNumber: 69))
ps.add(Pitch(midiNumber: 67))
print(ps)                                // [G4, A4]
```

##### Scales and chords are `Harmonizer` functions of the form `(Pitch -> PitchSet)`
```Swift
let major = Scale.Major
print(major(A4))                         // [A4, B4, C♯5, D5, E5, F♯5, G♯5]

let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(A4))                         // [C5, E5, A5, B5]
```

##### A custom chord can be created from any harmonizer
```Swift
let chord = Chord.create(Scale.Major, indices: [0, 2, 4, 6])
print(chord(A4))                         // [A4, C♯5, E5, G♯5]
```
