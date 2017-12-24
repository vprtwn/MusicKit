import XCTest
import MusicKit

final class ChordNameBasicTests: XCTestCase {
    func testPowerChord() {
        let sut: PitchSet = [Chroma.c*0, Chroma.g*0, Chroma.c*2]
        let name = Chord.name(sut)
        let expected = "C5"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testMajorMinor() {
        var sut: PitchSet = [Chroma.c*0, Chroma.e*2, Chroma.g*3, Chroma.c*4]
        var name = Chord.name(sut)
        var expected = "CM"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.e*2, Chroma.g*3, Chroma.c*4, Chroma.g*4]
        name = Chord.name(sut)
        expected = "CM/E"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*0, Chroma.ds*2, Chroma.g*3, Chroma.c*4, Chroma.g*4]
        name = Chord.name(sut)
        expected = "Cm/G"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testOtherTriads() {
        var sut: PitchSet = [Chroma.c*0, Chroma.e*2, Chroma.gs*3, Chroma.c*4]
        var name = Chord.name(sut)
        var expected = "C+"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.ds*2, Chroma.fs*3, Chroma.c*4, Chroma.fs*4]
        name = Chord.name(sut)
        expected = "C°/E♭"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*2, Chroma.d*3, Chroma.c*4, Chroma.g*4]
        name = Chord.name(sut)
        expected = "Gsus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.c*2, Chroma.f*3, Chroma.c*4, Chroma.g*4]
        name = Chord.name(sut)
        expected = "Csus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.c*2, Chroma.d*3, Chroma.c*4, Chroma.g*4]
        name = Chord.name(sut)
        expected = "Csus2"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testCommonTetrads() {
        var sut: PitchSet = [Chroma.c*0, Chroma.e*2, Chroma.g*3, Chroma.as*4, Chroma.g*3]
        var name = Chord.name(sut)
        var expected = "C7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*0, Chroma.ds*2, Chroma.c*3, Chroma.as*4, Chroma.g*3]
        name = Chord.name(sut)
        expected = "Cm7/G"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.b*0, Chroma.g*2, Chroma.d*3, Chroma.fs*4, Chroma.g*3]
        name = Chord.name(sut)
        expected = "GΔ7/B"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.b*0, Chroma.d*2, Chroma.f*3, Chroma.gs*4, Chroma.d*3]
        name = Chord.name(sut)
        expected = "B°7"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testOtherTetrads() {
        var sut: PitchSet = [Chroma.c*0, Chroma.ds*2, Chroma.g*3, Chroma.b*4, Chroma.g*3]
        var name = Chord.name(sut)
        var expected = "CmΔ7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.e*0, Chroma.c*2, Chroma.gs*3, Chroma.b*4, Chroma.gs*3]
        name = Chord.name(sut)
        expected = "C+Δ7/E"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.b*0, Chroma.g*2, Chroma.ds*3, Chroma.f*4, Chroma.g*3]
        name = Chord.name(sut)
        expected = "B+add♯11"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.b*0, Chroma.d*2, Chroma.f*3, Chroma.a*4, Chroma.d*3]
        name = Chord.name(sut)
        expected = "Bø7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.b*0, Chroma.cs*2, Chroma.f*3, Chroma.g*4, Chroma.cs*3]
        name = Chord.name(sut)
        expected = "G7♭5/B"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.c*0, Chroma.e*2, Chroma.fs*3, Chroma.b*4, Chroma.c*3]
        name = Chord.name(sut)
        expected = "Esus2/C"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.c*0, Chroma.g*2, Chroma.f*3, Chroma.as*4, Chroma.c*3]
        name = Chord.name(sut)
        expected = "C7sus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*0, Chroma.g*2, Chroma.f*3, Chroma.b*4, Chroma.c*3]
        name = Chord.name(sut)
        expected = "CΔ7sus4/G"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*0, Chroma.d*2, Chroma.b*3, Chroma.e*4, Chroma.g*3]
        name = Chord.name(sut)
        expected = "G6"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.g*0, Chroma.d*2, Chroma.as*3, Chroma.e*4, Chroma.g*3]
        name = Chord.name(sut)
        expected = "Gm6"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }
}
