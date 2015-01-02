import MusicKit


print(MusicKit.concertA)

var collection = ScaleCollection(firstPitch: Pitch(midiNumber: 23),
    scale: Scale.Major,
    end: 14)

for p in collection {
    print("\(p.noteName) \(p.frequency)\n")
}