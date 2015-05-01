# MusicKit

MusicKit is a Swift framework for programmatically interacting with musical abstractions.

```swift
let C5 = Pitch(midi: 72)
let neapolitan = Major.bII
print(neapolitan(C5))       // [C♯5, E♯5, G♯5]
let G4 = Pitch(pitchClass: PitchClass.G, octave: 4)
let plagalCadence = [Major.IV, Major.I]
print(plagalCadence * G4)   // [[C5, E5, G5], [G4, B4, D5]]
```

```swift
let V7ofV = Harmony.create(Scale.Major, degree: 5, chord: Major.V7)
print(V7ofV(C5))      // [D6, F♯6, A6, C7]
```

* [Framework Overview](/Documentation/FrameworkOverview.md)



