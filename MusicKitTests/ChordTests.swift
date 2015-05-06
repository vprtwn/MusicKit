import XCTest
import MusicKit

final class ChordTests: XCTestCase {
    func testCreateWithHarmonizer() {
        var sut = Chord.create(Scale.Major, indices: [1, 3, 5, 8, 10])
        var ps = sut(Chroma.C*0)
        XCTAssertEqual(ps, [Chroma.C*0, Chroma.E*0, Chroma.G*0, Chroma.C*1, Chroma.E*1])

        // if indices not 1-indexed, should return identity harmonizer
        sut = Chord.create(Scale.Major, indices: [0])
        ps = sut(Chroma.C*0)
        XCTAssertEqual(ps, [Chroma.C*0])
    }
}
