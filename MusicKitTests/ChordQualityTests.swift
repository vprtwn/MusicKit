import XCTest
import MusicKit

final class ChordQualityTests: XCTestCase {
    func testUniqueIntervals() {
        var seen = [String: String]()
        for quality in ChordQuality.All {
            let key = quality.intervals.reduce("", combine: { (s, i) -> String in
                s + "\(i)"
            })
            if let value = seen[key] {
                XCTFail("intervals for [\(quality.description)] collide with [\(value)]")
            }
            seen[key] = quality.description
        }
    }
}
