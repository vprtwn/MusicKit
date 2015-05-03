import XCTest
import MusicKit

final class PitchSetTests: XCTestCase {
    func testSliceable() {
        let ps : PitchSet = [Pitch(midi: 20), Pitch(midi: 21), Pitch(midi: 22)]
        let slice = ps[0...1]
        XCTAssertEqual(PitchSet(slice),
            PitchSet([Pitch(midi: 20), Pitch(midi: 21)]))
    }

}
