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

    func testAddInt() {
        var sut = Chroma.B
        sut = sut + 1
        XCTAssertEqual(sut, Chroma.C)
        sut = sut + 11
        XCTAssertEqual(sut, Chroma.B)
    }

    func testSubtractInt() {
        var sut = Chroma.C
        sut = sut - 1
        XCTAssertEqual(sut, Chroma.B)
        sut = sut - 11
        XCTAssertEqual(sut, Chroma.C)
    }

    func testSubtractChroma() {
        var d = Chroma.C - Chroma.Cs
        XCTAssertEqual(d, 1)
        d = Chroma.Cs - Chroma.C
        XCTAssertEqual(d, 1)
        d = Chroma.C - Chroma.Fs
        XCTAssertEqual(d, 6)
    }

    func testDescription() {
        let sut = Chroma.C
        let description = sut.description
        XCTAssertEqual(description, "C")
    }
}
