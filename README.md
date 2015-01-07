# MusicKit

Work in progress. Open `MusicKit.xcworkspace` to try the included playground.

##### Create a `Pitch` using either a MIDI number or a frequency
```Swift
let p1 = Pitch(midiNumber: 69)
println(p1.pitchClass)                   // A♮
println(p1.noteName)                     // A4
println(p1.frequency)                    // 440.0
```

##### Create common scales using the provided `Scale` constants
```Swift
let majorScale = Scale.Major
let wholetoneScale = Scale.Wholetone
```

##### Create common chords using the provided `Chord` constants
```
let majorSeventh = Chord.MajorSeventh
let halfDiminished = Chord.HalfDiminishedSeventh
```

##### Create a `PitchSet` with a scale, a starting pitch, and a count
```Swift
let scalePitchSet = PitchSet(scale: Scale.Major,
    firstPitch: Pitch(midiNumber: 69), count: 7)
for p in scalePitchSet {
    println(p.noteName)
}
// A4 B4 C♯5 D5 E5 F♯5 G♯5
```

##### A `PitchSet` can also be created with a chord
```Swift
let chordPitchSet = PitchSet(chord: Chord.MinorSeventh,
    firstPitch: Pitch(midiNumber: 69), count: 7)
for p in chordPitchSet {
    println(p.noteName)
}
// A4 C5 E5 G5 A5 C6 E6
```

