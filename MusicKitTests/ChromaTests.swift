import XCTest
import MusicKit

final class ChromaTests: XCTestCase {
    func testEquatable() {
        let c1 = Chroma.C
        let c2 = Chroma.D
        XCTAssertNotEqual(c1, c2)
    }

    func testHashable() {
        var d = [Chroma : Int]()
        d[.C] = 1
        XCTAssert(d[.C] == Optional(1))
    }
}
