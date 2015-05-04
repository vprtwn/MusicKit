import XCTest
import MusicKit

final class LetterNameTests: XCTestCase {
    func testDescription() {
        let sut = LetterName.G
        let description = sut.description
        XCTAssertEqual(description, "G")
    }

    func testAddition() {
        var sut = LetterName.C
        sut = sut + 1
        XCTAssertEqual(sut, LetterName.D)
        sut = sut + 6
        XCTAssertEqual(sut, LetterName.C)
    }

    func testSubtraction() {
        var sut = LetterName.C
        sut = sut - 1
        XCTAssertEqual(sut, LetterName.B)
        sut = sut - 6
        XCTAssertEqual(sut, LetterName.C)
    }
}
