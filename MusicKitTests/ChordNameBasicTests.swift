import XCTest
import MusicKit

final class ChordNameBasicTests: XCTestCase {
    func testPowerChord() {
        let sut: PitchSet = [Chroma.C*0, Chroma.G*0, Chroma.C*2]
        let name = Chord.name(sut)
        let expected = "C5"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testMajorMinor() {
        var sut: PitchSet = [Chroma.C*0, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "CM"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.E*2, Chroma.G*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "CM/E"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*0, Chroma.Ds*2, Chroma.G*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "Cm/G"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testOtherTriads() {
        var sut: PitchSet = [Chroma.C*0, Chroma.E*2, Chroma.Gs*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "C+"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.Ds*2, Chroma.Fs*3, Chroma.C*4, Chroma.Fs*4]
        name = Chord.name(sut)
        expected = "C°/E♭"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*2, Chroma.D*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "Gsus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.C*2, Chroma.F*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "Csus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.C*2, Chroma.D*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "Csus2"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testCommonTetrads() {
        var sut: PitchSet = [Chroma.C*0, Chroma.E*2, Chroma.G*3, Chroma.As*4, Chroma.G*3]
        var name = Chord.name(sut)
        var expected = "C7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*0, Chroma.Ds*2, Chroma.C*3, Chroma.As*4, Chroma.G*3]
        name = Chord.name(sut)
        expected = "Cm7/G"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.B*0, Chroma.G*2, Chroma.D*3, Chroma.Fs*4, Chroma.G*3]
        name = Chord.name(sut)
        expected = "GΔ7/B"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.B*0, Chroma.D*2, Chroma.F*3, Chroma.Gs*4, Chroma.D*3]
        name = Chord.name(sut)
        expected = "B°7"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testOtherTetrads() {
        var sut: PitchSet = [Chroma.C*0, Chroma.Ds*2, Chroma.G*3, Chroma.B*4, Chroma.G*3]
        var name = Chord.name(sut)
        var expected = "CmΔ7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.E*0, Chroma.C*2, Chroma.Gs*3, Chroma.B*4, Chroma.Gs*3]
        name = Chord.name(sut)
        expected = "C+Δ7/E"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.B*0, Chroma.G*2, Chroma.Ds*3, Chroma.F*4, Chroma.G*3]
        name = Chord.name(sut)
        expected = "B+add♯11"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.B*0, Chroma.D*2, Chroma.F*3, Chroma.A*4, Chroma.D*3]
        name = Chord.name(sut)
        expected = "Bø7"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.B*0, Chroma.Cs*2, Chroma.F*3, Chroma.G*4, Chroma.Cs*3]
        name = Chord.name(sut)
        expected = "G7♭5/B"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.C*0, Chroma.E*2, Chroma.Fs*3, Chroma.B*4, Chroma.C*3]
        name = Chord.name(sut)
        expected = "Esus2/C"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.C*0, Chroma.G*2, Chroma.F*3, Chroma.As*4, Chroma.C*3]
        name = Chord.name(sut)
        expected = "C7sus4"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*0, Chroma.G*2, Chroma.F*3, Chroma.B*4, Chroma.C*3]
        name = Chord.name(sut)
        expected = "CΔ7sus4/G"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*0, Chroma.D*2, Chroma.B*3, Chroma.E*4, Chroma.G*3]
        name = Chord.name(sut)
        expected = "G6"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.G*0, Chroma.D*2, Chroma.As*3, Chroma.E*4, Chroma.G*3]
        name = Chord.name(sut)
        expected = "Gm6"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }
}
