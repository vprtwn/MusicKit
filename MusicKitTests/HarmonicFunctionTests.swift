import XCTest
import MusicKit

final class HarmonicFunctionTests: XCTestCase {
    func testMajorNeapolitan() {
        let C5 = Pitch(midi: 72)
        let neapolitan = Major.bII
        let pitchSet = neapolitan(C5)
        XCTAssertEqual(pitchSet,
            [Pitch(chroma: Chroma.cs, octave: 5),
            Pitch(chroma: Chroma.f, octave: 5),
            Pitch(chroma: Chroma.gs, octave: 5)])
    }

    func testMinorNeapolitan() {
        let C5 = Pitch(midi: 72)
        let neapolitan = Minor.bII
        let pitchSet = neapolitan(C5)
        XCTAssertEqual(pitchSet,
            [Pitch(chroma: Chroma.cs, octave: 5),
            Pitch(chroma: Chroma.f, octave: 5),
            Pitch(chroma: Chroma.gs, octave: 5)])
    }
}
