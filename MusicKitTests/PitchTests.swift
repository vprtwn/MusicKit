import XCTest
import MusicKit

final class PitchTests: XCTestCase {
    func testInitWithIntegralMidiNumber() {
        let sut = Pitch(midi: 69)
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.A))
    }

    func testInitWithNonIntegralMidiNumber() {
        let sut = Pitch(midi: 69.5)
        XCTAssertEqual(sut.midi, 69.5)
        XCTAssert(sut.chroma == nil)
    }

    func testInitWithChromaOctave() {
        let sut = Pitch(chroma: .A, octave: 4)
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.A))
    }

    func testInitWithChromaOctaveSugar() {
        let sut = Chroma.A*4
        XCTAssertEqual(sut.midi, 69)
        XCTAssert(sut.chroma == Optional(Chroma.A))
    }

    func testDescription() {
        let sut = Chroma.C*5
        let description = sut.description
        XCTAssertEqual(description, "C5")
    }

    func testTransposable() {
        var sut = Chroma.C*5
        sut = sut.transpose(12)
        XCTAssertEqual(sut, Chroma.C*6)
        sut = sut.transpose(-24)
        XCTAssertEqual(sut, Chroma.C*4)
    }
}
