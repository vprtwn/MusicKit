import XCTest
import MusicKit

final class PitchTests: XCTestCase {
    func testInitWithIntegralMidiNumber() {
        let sut = Pitch(midi: 69)
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.a))
    }

    func testInitWithNonIntegralMidiNumber() {
        let sut = Pitch(midi: 69.5)
        XCTAssertEqual(sut.midi, 69.5)
        XCTAssert(sut.chroma == nil)
    }

    func testInitWithChromaOctave() {
        let sut = Pitch(chroma: .a, octave: 4)
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.a))
    }

    func testInitWithChromaOctaveSugar() {
        let sut = Chroma.a*4
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.a))
    }

    func testDescription() {
        let sut = Chroma.c*5
        let description = sut.description
        XCTAssertEqual(description, "C5")
    }

    func testTransposable() {
        var sut = Chroma.c*5
        sut = sut.transpose(12)
        XCTAssertEqual(sut, Chroma.c*6)
        sut = sut.transpose(-24)
        XCTAssertEqual(sut, Chroma.c*4)
    }
}
