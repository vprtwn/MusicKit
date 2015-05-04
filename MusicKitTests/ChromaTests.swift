import XCTest
import MusicKit

final class ChromaTests: XCTestCase {
    func testEquatable() {
        let sut1 = Chroma.C
        let sut2 = Chroma.D
        XCTAssertNotEqual(sut1, sut2)
    }

    func testHashable() {
        let sut = Chroma.C
        let hashValue = sut.hashValue
        XCTAssertEqual(hashValue, 0.hashValue)
    }

    func testAddition() {
        var sut = Chroma.B
        sut = sut + 1
        XCTAssertEqual(sut, Chroma.C)
        sut = sut + 11
        XCTAssertEqual(sut, Chroma.B)
    }

    func testSubtraction() {
        var sut = Chroma.C
        sut = sut - 1
        XCTAssertEqual(sut, Chroma.B)
        sut = sut - 11
        XCTAssertEqual(sut, Chroma.C)
    }

    func testDescription() {
        var sut = Chroma.C
        let description = sut.description
        XCTAssertEqual(description, "C")
    }
}
