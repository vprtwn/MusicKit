import XCTest
import MusicKit

final class ChordNameExtendedTests: XCTestCase {
    ///*
    func testSlashTetrads() {
        var sut : PitchSet = [Chroma.Cs*0, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "CM/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.Fs*0, Chroma.Ds*2, Chroma.G*3, Chroma.C*4]
        name = Chord.name(sut)
        expected = "Cm/F♯"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testPentads() {
        var sut : PitchSet = [Chroma.As*0, Chroma.Cs*1, Chroma.E*1, Chroma.G*1, Chroma.C*2]
        var name = Chord.name(sut)
        var expected = "B♭°9"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testSlashPentads() {
        var sut : PitchSet = [Chroma.Cs*0, Chroma.As*1, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "C7/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.E*0, Chroma.As*1, Chroma.Ds*2, Chroma.G*3, Chroma.C*4]
        name = Chord.name(sut)
        expected = "Cm7/E"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testHexads() {
        var sut : PitchSet = [Chroma.C*0, Chroma.E*0, Chroma.Gs*0, Chroma.B*0, Chroma.D*1, Chroma.F*1]
        var name = Chord.name(sut)
        var expected = "C+Δ11"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testHeptads() {
        var sut : PitchSet = [Chroma.C*0, Chroma.E*0, Chroma.G*0, Chroma.As*0, Chroma.D*1, Chroma.F*1, Chroma.Gs*1]
        var name = Chord.name(sut)
        var expected = "C11♭13"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }
    //*/
}
