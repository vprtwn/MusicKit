# MusicKit

### Pitch
* A `Pitch` is initialized with a MIDI number.
* Non-integral MIDI numbers can be used to create microtones.

```swift
let p1 = Pitch(midi: 69)
println(p1.pitchClass)  // A♮
println(p1.noteName)    // A4
println(p1.frequency)   // 440.0
```

* Changing the value of MusicKit's concert A changes the computed frequency of all pitches.

```swift
MusicKit.concertA = 444
println(p1.frequency)   // 444.0
MusicKit.concertA = 440
```

### PitchSet
* A `PitchSet` is a collection of unique `Pitch` instances ordered by frequency.

```swift
var ps1 = PitchSet()
ps1.insert(Pitch(midi: 40))
ps1.insert(Pitch(midi: 42))
print(ps1)   // [E2, F♯2]

var ps2 = PitchSet()
ps2.insert(Pitch(midi: 60))
ps2.insert(Pitch(midi: 72))
ps2.insert(Pitch(midi: 81))
print(ps2)  // [C4, C5, A5]

print(ps1 + ps2)     // [E2, F♯2, C4, C5, A5]
print(ps1 == ps2)    // false
print(ps2.pitchClassSet())  // C, A
```

### Harmonizer
* A `Harmonizer` is a function with the signature `(Pitch -> PitchSet)`.
* `Scale` and `Chord` contain common scale and chord harmonizers.
* `Major`, `Minor`, and `Harmony` can be used to create functional harmony.

### Scale
* `Scale` contains common scale harmonizers.

```swift
let major = Scale.Major
print(major(Pitch(midi: 69)))   // [A4, B4, C♯5, D5, E5, F♯5, G♯5]
```

* The `Scale` enum also provides a way to create a custom scale from an array of semitone intervals.

```swift
let equidistantPentatonic = Scale.create([2.4, 2.4, 2.4, 2.4, 2.4])
```

### Chord
* `Chord` contains common chord harmonizers.
* Chords are in root position by default. You may also specify the inversion and any additions.

```swift
let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(Pitch(midi: 69)))   // [C5, E5, A5, B5]
```

* `Chord` also provides a function to create a chord based on a `Harmonizer` (typically a scale).

```swift
let chord = Chord.create(major, indices: [0, 2, 4, 6])
let ch = chord(Pitch(midi: 69))
print(ch) // [A4, C♯5, E5, G♯5]
```

### Functional harmony
* `Major` and `Minor` contain harmonizers for creating diatonic functional harmony.

```swift
let neapolitan = Major.bII
let plagalCadence = [Major.IV, Major.I]
```

* `Harmony` provides a way to create custom functional harmonizers.

```swift
let germanAugmentedSixth = Harmony.create(Scale.Major, degree: 4.5, chord: Chord.DominantSeventh)
```



