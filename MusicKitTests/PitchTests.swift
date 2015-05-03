import XCTest
import MusicKit

final class PitchTests: XCTestCase {
    func testInitWithIntegralMidiNumber() {
        let p = Pitch(midi: 69)
        XCTAssertEqual(p.midi, 69)
        XCTAssert(p.chroma == Optional(Chroma.A))
    }

    func testInitWithNonIntegralMidiNumber() {
        let p = Pitch(midi: 69.5)
        XCTAssertEqual(p.midi, 69.5)
        XCTAssert(p.chroma == nil)
    }
}
