import XCTest
import MusicKit

final class MKUtilTests: XCTestCase {
    func testRotate() {
        var sut = [1, 2, 3]
        sut = MKUtil.rotate(sut, 1)
        XCTAssertEqual(sut, [2, 3, 1])
    }
}
