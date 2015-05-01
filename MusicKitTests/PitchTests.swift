import XCTest
import MusicKit

final class PitchTests: XCTestCase {
    func testInitWithIntegralMidiNumber() {
        let p = Pitch(midi: 69)
        XCTAssertTrue(p.midi == 69)
        XCTAssertTrue(p.pitchClass == Optional(PitchClass.A))
    }

    func testInitWithNonIntegralMidiNumber() {
        let p = Pitch(midi: 69.5)
        XCTAssertTrue(p.midi == 69.5)
        XCTAssertTrue(p.pitchClass == nil)
    }
}
