#MusicKit
## Pitch
* Pitches are specified by MIDI number.
* Note: non-integral midi values can be used for microtones

```swift
let p1 = Pitch(midi: 69)
println(p1.pitchClass)  // A♮
println(p1.noteName)    // A4
println(p1.frequency)   // 440.0
```

* Changing the value of concert A changes the computed frequency of all pitches

```swift
MusicKit.concertA = 444
println(p1.frequency)   // 444.0
MusicKit.concertA = 440
```

## PitchSet ==
 * A `PitchSet` is a set of `Pitch` objects

```swift
var ps = PitchSet()
ps.add(Pitch(midi: 40))
ps.add(Pitch(midi: 42))
print(ps)   // [E2, F♯2]

var ps2 = PitchSet()
ps2.add(Pitch(midi: 60))
ps2.add(Pitch(midi: 72))
ps2.add(Pitch(midi: 81))
print(ps2)  // [C4, C5, A5]

let a = ps + ps2
print(a)    // [E2, F♯2, C4, C5, A5]
```

## Harmonizer
* A `Harmonizer` is a function with the signature `(Pitch -> PitchSet)`
* The `Scale` and `Chord` enums define common scales and chords as Harmonizers

### Scale
* Given a `Pitch`, any `Harmonizer` will return a `PitchSet`.

```swift
let major = Scale.Major
print(major(Pitch(midi: 69)))   // [A4, B4, C♯5, D5, E5, F♯5, G♯5]
```

* Custom scales can be created using an array of semitone intervals

```swift
let equidistantPentatonic = Scale.create([2.4, 2.4, 2.4, 2.4, 2.4])
```

### Chord
* When creating a chord, you must also specify the inversion and any additions

```swift
let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(Pitch(midi: 69)))   // [C5, E5, A5, B5]
```

* A scale can be used to create a chord

```swift
let chord = Chord.create(major, indices: [0, 2, 4, 6])
let ch = chord(Pitch(midi: 69))
print(ch) // [A4, C♯5, E5, G♯5]
```






