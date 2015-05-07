import XCTest
import MusicKit

// TODO: test these once there's a way to expose internal methods in tests
final class MKUtilTests: XCTestCase {
    func testRotate() {

    }

    func testInvert() {

    }

    func testSemitoneIndices() {

    }

    func testIntervals() {

    }

    func testInsertionIndex() {

    }

    func testCompress() {
        let sut : [Float] = [0, 4, 7, 18]
        let result = MKUtil.compress(sut)
        XCTAssertEqual(result, [0, 4, 6, 7])
    }
}
