import XCTest
import MusicKit

final class PitchSetTests: XCTestCase {
    func testInitWithDuplicate() {
        var sut: PitchSet = [Chroma.C*2, Chroma.C*2]
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet(pitches: Chroma.C*2, Chroma.C*2)
        XCTAssertEqual(sut.count, 1)
        sut = PitchSet([Chroma.C*2, Chroma.C*2])
        XCTAssertEqual(sut.count, 1)
    }

    func testInsertDuplicate() {
        var sut: PitchSet = [Chroma.C*2]
        XCTAssertEqual(sut.count, 1)
        sut.insert(Chroma.C*2)
        XCTAssertEqual(sut.count, 1)
        sut.insert([Chroma.C*2, Chroma.C*3])
        XCTAssertEqual(sut.count, 2)
    }

    func testSliceable() {
        let sut: PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*4]
        let slice = sut[0...1]
        XCTAssertEqual(PitchSet(slice),
            PitchSet([Chroma.C*2, Chroma.C*3]))
    }

    func testTransposable() {
        var sut: PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*4]
        sut = sut.transpose(2)
        XCTAssertEqual(sut, [Chroma.D*2, Chroma.D*3, Chroma.D*4])
    }

    func testFilter() {
        var sut: PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*5]
        sut = PitchSet(sut.filter { $0.midi != 72 })
        XCTAssertEqual(sut, [Chroma.C*2, Chroma.C*3])
    }

    func testMap() {
        let sut: PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5]
        let result = sut.map { $0.midi }
        XCTAssertEqual(result, [72, 73, 74])
    }

    func testReduce() {
        let sut: PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5]
        let result = sut.reduce(0, combine: { (a, r) in a + r.midi })
        XCTAssertEqual(result, 219)
    }

    func testSemitoneIndices() {
        var sut: PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5]
        var result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 1, 2])

        sut = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 4, 7])

        sut = [Pitch(midi: 0), Pitch(midi: 0.5), Pitch(midi: 1.0)]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 0.5, 1])

        sut = [Chroma.C*0, Chroma.E*0, Chroma.Fs*0, Chroma.G*0]
        result = sut.semitoneIndices()
        XCTAssertEqual(result, [0, 4, 6, 7])
    }

    func testHarmonizer() {
        let sut: PitchSet = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        let h = sut.harmonizer()
        let result = h(Chroma.C*5)
        XCTAssertEqual(result, sut)
    }

    func testHarmonicFunction() {
        let sut: PitchSet = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        let h = sut.harmonicFunction(Scale.Major, 5)
        let result = h(Chroma.F*4)
        XCTAssertEqual(result, sut)
    }

    func testExtend() {
        var sut: PitchSet = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        sut.extend(0)
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.E*5, Chroma.G*5])

        sut.extend(1)
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.E*5, Chroma.G*5, Chroma.C*6, Chroma.E*6, Chroma.G*6])

        sut = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        sut.extend(-1)
        XCTAssertEqual(sut, [Chroma.C*4, Chroma.E*4, Chroma.G*4, Chroma.C*5, Chroma.E*5, Chroma.G*5])
    }

    func testDedupe() {
        var sut: PitchSet = [Chroma.C*5, Chroma.C*6, Chroma.G*6, Chroma.C*7,]
        sut.dedupe()
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.G*6])
    }

    func testCollapse() {
        var sut: PitchSet = [Chroma.C*5, Chroma.G*6, Chroma.E*7, Chroma.C*8]
        sut.collapse()
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.E*5, Chroma.G*5, Chroma.C*6])
    }

    func testInvert() {
        var sut: PitchSet = [Chroma.C*5, Chroma.E*5, Chroma.G*5]
        sut.invert(0)
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.E*5, Chroma.G*5])
        sut.invert()
        XCTAssertEqual(sut, [Chroma.E*5, Chroma.G*5, Chroma.C*6])
        sut.invert(2)
        XCTAssertEqual(sut, [Chroma.C*6, Chroma.E*6, Chroma.G*6])
    }
}
