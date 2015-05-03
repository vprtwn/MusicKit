import XCTest
import MusicKit

final class PitchTests: XCTestCase {
    func testInitWithIntegralMidiNumber() {
        let p = Pitch(midi: 69)
        XCTAssertTrue(p.midi == 69)
        XCTAssertTrue(p.chroma == Optional(Chroma.A))
    }

    func testInitWithNonIntegralMidiNumber() {
        let p = Pitch(midi: 69.5)
        XCTAssertTrue(p.midi == 69.5)
        XCTAssertTrue(p.chroma == nil)
    }
}
