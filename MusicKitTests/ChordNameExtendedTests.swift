import XCTest
import MusicKit

final class ChordNameExtendedTests: XCTestCase {
    func testSlashTetrads() {
        var sut: PitchSet = [Chroma.cs*0, Chroma.e*2, Chroma.g*3, Chroma.c*4]
        var name = Chord.name(sut)
        var expected = "CM/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.fs*0, Chroma.ds*2, Chroma.g*3, Chroma.c*4]
        name = Chord.name(sut)
        expected = "Cm/F♯"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testPentads() {
        let sut: PitchSet = [Chroma.as*0, Chroma.cs*1, Chroma.e*1, Chroma.g*1, Chroma.c*2]
        let name = Chord.name(sut)
        let expected = "B♭°9"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testSlashPentads() {
        var sut: PitchSet = [Chroma.cs*0, Chroma.as*1, Chroma.e*2, Chroma.g*3, Chroma.c*4]
        var name = Chord.name(sut)
        var expected = "C7/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.e*0, Chroma.as*1, Chroma.ds*2, Chroma.g*3, Chroma.c*4]
        name = Chord.name(sut)
        expected = "Cm7/E"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testHexads() {
        let sut: PitchSet = [Chroma.c*0, Chroma.e*0, Chroma.gs*0, Chroma.b*0, Chroma.d*1, Chroma.f*1]
        let name = Chord.name(sut)
        let expected = "C+Δ11"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testHeptads() {
        let sut: PitchSet = [Chroma.c*0, Chroma.e*0, Chroma.g*0, Chroma.as*0, Chroma.d*1, Chroma.f*1, Chroma.gs*1]
        let name = Chord.name(sut)
        let expected = "C11♭13"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }
}
