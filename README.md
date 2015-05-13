# MusicKit

MusicKit is a framework and DSL for creating, analyzing, and transforming music in Swift.

The primary goal of MusicKit is to provide flexible abstractions for core musical concepts.

Secondary goals include:
- MIDI I/O
- MIR tools

Here are a few examples:

**Functional Harmony**
```swift
let C5 = Pitch(midi: 72)
let neapolitan = Major.bII
print(neapolitan(C5))               // [C♯5, E♯5, G♯5]
let G4 = Chroma.G*4
let plagalCadence = [Major.IV, Major.I]
print(plagalCadence * G4)           // [[C5, E5, G5], [G4, B4, D5]]
let V7ofV = HarmonicFunction.create(Scale.Major, degree: 5, chord: Major.V7)
print(V7ofV(C5))                    // [D6, F♯6, A6, C7]
```

**Chord Identification**
```swift
let pitchSet : PitchSet = [Chroma.B*0, Chroma.Cs*2, Chroma.F*3, Chroma.G*4]
print(Chord.name(pitchSet))         // G7♭5/B
// Chord.parse returns a tuple of (chord quality, root chroma, bass chroma)
print(Chord.parse(pitchSet))        // (dominant seventh flat five, G, B)
```

**MIDI transformation**
```swift
let midi = MIDI(name: "WholetoneClusters")
midi.noteMessageHandler = { messages in
    if let first = messages.first {
        midi.send([first, first.transpose(2), first.transpose(3)])
    }
}
```

**[Framework Overview](/Documentation/FrameworkOverview.md)**

