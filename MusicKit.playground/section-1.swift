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
ps.add(Pitch(midiNumber: 42))
print(ps)

var ps2 = PitchSet()
ps2.add(Pitch(midiNumber: 60))
ps2.add(Pitch(midiNumber: 72))
ps2.add(Pitch(midiNumber: 81))
print(ps2)


let a = ps + ps2
print(a)

// A Scale given a Pitch will return a PitchSet
let major = Scale.Major
print(major(Pitch(midiNumber: 69)))

// Create a custom scale using an array of semitone intervals
//let customScale = Scale(intervals: [2.4, 2.4, 2.4, 2.4, 2.4],
//    name: "Equidistant Pentatonic")

//== Chord ==
// Create common chords using the provided Chord constants
//let majorSeventh = Chord.MajorSeventh
//let halfDiminished = Chord.HalfDiminishedSeventh


let minor = Chord.Minor(inversion: 1, additions: [.Nine])
print(minor(Pitch(midiNumber: 69)))

let chord = Chord.create(major, indices: [0, 2, 4, 6])
let ch = chord(Pitch(midiNumber: 69))
print(ch)


let maxIndex : UInt = [1, 0, 4, 10, 6, 3].reduce(0, combine: { a, x in
    if (a > UInt(x)) {
        return a
    }
    else {
        return UInt(x)
    }
})

// Create a custom chord using an array of semitones from the root
//let superMajor = Chord(intervals: [0, 4.5, 6], name: "Supermajor",
//    inversion: 0)

//== PitchSet ==
// Create a PitchSet with a scale, a starting pitch, and a count
//let scalePitchSet = PitchSet(scale: Scale.Major,
//    firstPitch: Pitch(midiNumber: 69), count: 7)
//for p in scalePitchSet {
//    println(p.noteName)
//}
// A4 B4 C♯5 D5 E5 F♯5 G♯5

// A PitchSet can also be created with a chord
//let chordPitchSet = PitchSet(chord: Chord.DiminishedSeventh,
//    firstPitch: Pitch(midiNumber: 72), count: 7)
//for p in chordPitchSet {
//    println(p.noteName)
//}
// C5 E♭5 G♭5 B𝄫5 C6 E♭6 G♭6



