import XCTest
import MusicKit

final class IntervalTests: XCTestCase {
    func testHarmonizers() {
        var sut = Interval.Unison(Chroma.c*5)
        XCTAssertEqual(sut, [Chroma.c*5])

        sut = Interval.MajorTenth(Chroma.c*5)
        XCTAssertEqual(sut, [Chroma.c*5, Chroma.e*6])
    }
}
