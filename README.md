# MusicKit

Open `MusicKit.xcworkspace` to try the included playground.

```Swift
import MusicKit

// Create a Pitch using either a MIDI number or a frequency.
let p1 = Pitch(midiNumber: 69)
println(p1.pitchClass)                   // A♮
println(p1.noteName)                     // A4
println(p1.frequency)                    // 440.0

// A Pitch initialized with a frequency may not have an associated 
// pitch class or note name.
let p2 = Pitch(frequency: 445)
println(p2.midiNumber)                   // 69.1956
println(p2.pitchClass)                   // nil
println(p2.noteName)                     // ""

// Changing the value of concert A changes the computed frequency 
// of all pitches.
MusicKit.concertA = 444
println(p1.frequency)                    // 444.0
MusicKit.concertA = 440

// Create common scales using the provided Scale constants.
let majorScale = Scale.Major
let wholetoneScale = Scale.Wholetone

// Create a custom scale using an array of semitone intervals that sum 
// to a multiple of 12.
let customScale = Scale(intervals: [2.4, 2.4, 2.4, 2.4, 2.4])

// Use a ScaleCollection to create a collection of pitches from the given
// starting pitch and scale
var majorScaleCollection = ScaleCollection(firstPitch: p1,
    scale: majorScale,
    end: 7)

// Note names in a scale collection will automatically use the correct
// enharmonic spelling for the given starting pitch and scale.
for p in majorScaleCollection {
    println(p.noteName)
}
// A4 B4 C♯5 D5 E5 F♯5 G♯5
```
