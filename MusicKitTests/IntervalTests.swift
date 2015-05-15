import XCTest
import MusicKit

final class IntervalTests: XCTestCase {
    func testHarmonizers() {
        var sut = Interval.Unison(Chroma.C*5)
        XCTAssertEqual(sut, [Chroma.C*5])

        sut = Interval.MajorTenth(Chroma.C*5)
        XCTAssertEqual(sut, [Chroma.C*5, Chroma.E*6])
    }
}
