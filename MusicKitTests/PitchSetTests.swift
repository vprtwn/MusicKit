import XCTest
import MusicKit

final class PitchSetTests: XCTestCase {
    func testInitWithDuplicate() {
        var sut : PitchSet = [Chroma.C*2, Chroma.C*2]
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet(pitches: Chroma.C*2, Chroma.C*2)
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet([Chroma.C*2, Chroma.C*2])
        XCTAssertEqual(sut.count, 1)
    }

    func testInsertDuplicate() {
        var sut : PitchSet = [Chroma.C*2]
        XCTAssertEqual(sut.count, 1)
        sut.insert(Chroma.C*2)
        XCTAssertEqual(sut.count, 1)
        sut.insert([Chroma.C*2, Chroma.C*3])
        XCTAssertEqual(sut.count, 2)
    }

    func testSliceable() {
        let sut : PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*4]
        let slice = sut[0...1]
        XCTAssertEqual(PitchSet(slice),
            PitchSet([Chroma.C*2, Chroma.C*3]))
    }

    func testTransposable() {
        var sut : PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*4]
        sut = sut.transpose(2)
        XCTAssertEqual(sut, [Chroma.D*2, Chroma.D*3, Chroma.D*4])
    }
}
