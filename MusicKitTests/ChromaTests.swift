import XCTest
import MusicKit

final class ChromaTests: XCTestCase {
    func testEquatable() {
        let sut1 = Chroma.c
        let sut2 = Chroma.d
        XCTAssertNotEqual(sut1, sut2)
    }

    func testHashable() {
        let sut = Chroma.c
        let hashValue = sut.hashValue
        XCTAssertEqual(hashValue, 0.hashValue)
    }

    func testAddInt() {
        var sut = Chroma.b
        sut = sut + 1
        XCTAssertEqual(sut, Chroma.c)
        sut = sut + 11
        XCTAssertEqual(sut, Chroma.b)
    }

    func testSubtractInt() {
        var sut = Chroma.c
        sut = sut - 1
        XCTAssertEqual(sut, Chroma.b)
        sut = sut - 11
        XCTAssertEqual(sut, Chroma.c)
    }

    func testSubtractChroma() {
        var d = Chroma.c - Chroma.cs
        XCTAssertEqual(d, 1)
        d = Chroma.cs - Chroma.c
        XCTAssertEqual(d, 1)
        d = Chroma.c - Chroma.fs
        XCTAssertEqual(d, 6)
    }

    func testDescription() {
        let sut = Chroma.c
        let description = sut.description
        XCTAssertEqual(description, "C")
    }
}
