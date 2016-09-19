import XCTest
import MusicKit

final class ChordTests: XCTestCase {
    func testCreateWithHarmonizer() {
        var sut = Chord.create(Scale.Major, indices: [1, 3, 5, 8, 10])
        var ps = sut(Chroma.c*0)
        XCTAssertEqual(ps, [Chroma.c*0, Chroma.e*0, Chroma.g*0, Chroma.c*1, Chroma.e*1])

        // if indices not 1-indexed, should return identity harmonizer
        sut = Chord.create(Scale.Major, indices: [0])
        ps = sut(Chroma.c*0)
        XCTAssertEqual(ps, [Chroma.c*0])
    }
}
