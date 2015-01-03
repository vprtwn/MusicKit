# MusicKit

Work in progress. Open `MusicKit.xcworkspace` to try the included playground.

##### Create a `Pitch` using either a MIDI number or a frequency.
```Swift
let p1 = Pitch(midiNumber: 69)
println(p1.pitchClass)                   // A♮
println(p1.noteName)                     // A4
println(p1.frequency)                    // 440.0
```

##### Changing the value of concert A changes the computed frequency of all pitches.
```Swift
MusicKit.concertA = 444
println(p1.frequency)                    // 444.0
```

##### Create common scales using the provided `Scale` constants.
```Swift
let majorScale = Scale.Major
let wholetoneScale = Scale.Wholetone
```

##### Create a custom scale using an array of intervals (in semitones) that sum to a multiple of 12.
```Swift
let customScale = Scale(intervals: [2.4, 2.4, 2.4, 2.4, 2.4])
```

##### Create a `PitchSet` with a scale, a starting pitch, and a count
```Swift
let pitchSet = PitchSet(scale: majorScale, firstPitch: p1, count: 7)
for p in pitchSet {
    println(p.noteName)
}
// A4 B4 C♯5 D5 E5 F♯5 G♯5
// correct enharmonic spellings!
```
