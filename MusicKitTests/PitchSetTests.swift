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

    func testFilter() {
        var sut : PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*5]
        sut = sut.filter { $0.midi != 72 }
        XCTAssertEqual(sut, [Chroma.C*2, Chroma.C*3])
    }

    func testMap() {
        let sut : PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5]
        let result = sut.map { $0.midi }
        XCTAssertEqual(result, [72, 73, 74])
    }

    func testReduce() {
        let sut : PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5]
        let result = sut.reduce(0, combine: { (a, r) in a + r.midi })
        XCTAssertEqual(result, 219)
    }
}
