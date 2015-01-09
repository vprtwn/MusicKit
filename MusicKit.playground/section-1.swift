import MusicKit

//== Pitch ==
// Create a Pitch using either a MIDI number or a frequency
let p1 = Pitch(midiNumber: 69)
println(p1.pitchClass)                   // A♮
println(p1.noteName)                     // A4
println(p1.frequency)                    // 440.0

// Changing the value of concert A changes the computed frequency 
// of all pitches
MusicKit.concertA = 444
println(p1.frequency)                    // 444.0
MusicKit.concertA = 440

var ps = PitchSet()
ps.add(Pitch(midiNumber: 40))
print(ps)
ps.add(Pitch(midiNumber: 41))
print(ps)
ps.add(Pitch(midiNumber: 40))
print(ps)
ps.add(Pitch(midiNumber: 39))
print(ps)

// A Scale given a Pitch will return a PitchSet
let major = Scale.Major(Pitch(midiNumber: 72))
let wholetone = Scale.Wholetone

// Create a custom scale using an array of semitone intervals
//let customScale = Scale(intervals: [2.4, 2.4, 2.4, 2.4, 2.4],
//    name: "Equidistant Pentatonic")

//== Chord ==
// Create common chords using the provided Chord constants
let majorSeventh = Chord.MajorSeventh
let halfDiminished = Chord.HalfDiminishedSeventh

// Create a custom chord using an array of semitones from the root
let superMajor = Chord(intervals: [0, 4.5, 6], name: "Supermajor",
    inversion: 0)

//== PitchSet ==
// Create a PitchSet with a scale, a starting pitch, and a count
//let scalePitchSet = PitchSet(scale: Scale.Major,
//    firstPitch: Pitch(midiNumber: 69), count: 7)
//for p in scalePitchSet {
//    println(p.noteName)
//}
// A4 B4 C♯5 D5 E5 F♯5 G♯5

// A PitchSet can also be created with a chord
let chordPitchSet = PitchSet(chord: Chord.DiminishedSeventh,
    firstPitch: Pitch(midiNumber: 72), count: 7)
for p in chordPitchSet {
    println(p.noteName)
}
// C5 E♭5 G♭5 B𝄫5 C6 E♭6 G♭6



