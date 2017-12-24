import XCTest
import MusicKit

final class PitchSetTests: XCTestCase {
    func testInitWithDuplicate() {
        var sut: PitchSet = [Chroma.c*2, Chroma.c*2]
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet(pitches: Chroma.c*2, Chroma.c*2)
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet([Chroma.c*2, Chroma.c*2])
        XCTAssertEqual(sut.count, 1)
    }

    func testInsertDuplicate() {
        var sut: PitchSet = [Chroma.c*2]
        XCTAssertEqual(sut.count, 1)
        sut.insert(Chroma.c*2)
        XCTAssertEqual(sut.count, 1)
        sut.insert([Chroma.c*2, Chroma.c*3])
        XCTAssertEqual(sut.count, 2)
    }

    func testSliceable() {
        let sut: PitchSet = [Chroma.c*2, Chroma.c*3, Chroma.c*4]
        let slice = sut[0...1]
        XCTAssertEqual(PitchSet(slice),
            PitchSet([Chroma.c*2, Chroma.c*3]))
    }

    func testTransposable() {
        var sut: PitchSet = [Chroma.c*2, Chroma.c*3, Chroma.c*4]
        sut = sut.transpose(2)
        XCTAssertEqual(sut, [Chroma.d*2, Chroma.d*3, Chroma.d*4])
    }

    func testFilter() {
        var sut: PitchSet = [Chroma.c*2, Chroma.c*3, Chroma.c*5]
        sut = PitchSet(sut.filter { $0.midi != 72 })
        XCTAssertEqual(sut, [Chroma.c*2, Chroma.c*3])
    }

    func testMap() {
        let sut: PitchSet = [Chroma.c*5, Chroma.cs*5, Chroma.d*5]
        let result = sut.map { $0.midi }
        XCTAssertEqual(result, [72, 73, 74])
    }

    func testReduce() {
        let sut: PitchSet = [Chroma.c*5, Chroma.cs*5, Chroma.d*5]
        let result = sut.reduce(0, { (a, r) in a + r.midi })
        XCTAssertEqual(result, 219)
    }

    func testSemitoneIndices() {
        var sut: PitchSet = [Chroma.c*5, Chroma.cs*5, Chroma.d*5]
        var result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 1, 2])

        sut = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 4, 7])

        sut = [Pitch(midi: 0), Pitch(midi: 0.5), Pitch(midi: 1.0)]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 0.5, 1])

        sut = [Chroma.c*0, Chroma.e*0, Chroma.fs*0, Chroma.g*0]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 4, 6, 7])
    }

    func testHarmonizer() {
        let sut: PitchSet = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        let h = sut.harmonizer()
        let result = h(Chroma.c*5)
        XCTAssertEqual(result, sut)
    }

    func testHarmonicFunction() {
        let sut: PitchSet = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        let h = sut.harmonicFunction(Scale.Major, 5)
        let result = h(Chroma.f*4)
        XCTAssertEqual(result, sut)
    }

    func testExtend() {
        var sut: PitchSet = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        sut = sut.extend(0)
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.e*5, Chroma.g*5])

        sut = sut.extend(1)
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.e*5, Chroma.g*5, Chroma.c*6, Chroma.e*6, Chroma.g*6])

        sut = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        sut = sut.extend(-1)
        XCTAssertEqual(sut, [Chroma.c*4, Chroma.e*4, Chroma.g*4, Chroma.c*5, Chroma.e*5, Chroma.g*5])
    }

    func testDedupe() {
        var sut: PitchSet = [Chroma.c*5, Chroma.c*6, Chroma.g*6, Chroma.c*7,]
        sut.dedupe()
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.g*6])
    }

    func testCollapse() {
        var sut: PitchSet = [Chroma.c*5, Chroma.g*6, Chroma.e*7, Chroma.c*8]
        sut.collapse()
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.e*5, Chroma.g*5, Chroma.c*6])
    }

    func testInvert() {
        var sut: PitchSet = [Chroma.c*5, Chroma.e*5, Chroma.g*5]
        sut.invert(0)
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.e*5, Chroma.g*5])
        sut.invert()
        XCTAssertEqual(sut, [Chroma.e*5, Chroma.g*5, Chroma.c*6])
        sut.invert(2)
        XCTAssertEqual(sut, [Chroma.c*6, Chroma.e*6, Chroma.g*6])
    }
}
