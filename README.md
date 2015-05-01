# MusicKit

MusicKit is a Swift framework for programmatically interacting with musical abstractions.

```swift
let neapolitan = Major.bII
let C5 = Pitch(midi: 72)
print(neapolitan(C5))  // [C♯5, E♯5, G♯5]
let plagalCadence = [Major.IV, Major.I] * C5
print(plagalCadence)   // [[F5, A5, C6], [C5, E5, G5]]
```

```swift
let V7ofV = Harmony.create(Scale.Major, degree: 5, chord: Major.V7)
print(V7ofV(C5))      // [D6, F♯6, A6, C7]
```

* [Framework Overview](/Documentation/FrameworkOverview)



