import XCTest
import MusicKit

final class LetterNameTests: XCTestCase {
    func testDescription() {
        let sut = LetterName.g
        let description = sut.description
        XCTAssertEqual(description, "G")
    }

    func testAddition() {
        var sut = LetterName.c
        sut = sut + 1
        XCTAssertEqual(sut, LetterName.d)
        sut = sut + 6
        XCTAssertEqual(sut, LetterName.c)
    }

    func testSubtraction() {
        var sut = LetterName.c
        sut = sut - 1
        XCTAssertEqual(sut, LetterName.b)
        sut = sut - 6
        XCTAssertEqual(sut, LetterName.c)
    }
}
