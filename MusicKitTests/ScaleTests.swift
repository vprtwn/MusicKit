import XCTest
import MusicKit

final class ScaleTests: XCTestCase {
    func testMajor() {
        let sut = Scale.Major(Chroma.c*5)
        let expected: PitchSet = [
            Chroma.c*5,
            Chroma.d*5,
            Chroma.e*5,
            Chroma.f*5,
            Chroma.g*5,
            Chroma.a*5,
            Chroma.b*5,
        ]
        XCTAssertEqual(sut, expected)
    }

    func testPhrygian() {
        let sut = Scale.Phrygian(Chroma.e*5)
        let expected: PitchSet = [
            Chroma.e*5,
            Chroma.f*5,
            Chroma.g*5,
            Chroma.a*5,
            Chroma.b*5,
            Chroma.c*6,
            Chroma.d*6,
        ]
        XCTAssertEqual(sut, expected)
    }

    func testChromatic() {
        let sut = Scale.Chromatic(Chroma.c*5)
        let chromatic: PitchSet = [Chroma.c*5, Chroma.cs*5, Chroma.d*5,
            Chroma.ds*5, Chroma.e*5, Chroma.f*5, Chroma.fs*5, Chroma.g*5,
            Chroma.gs*5, Chroma.a*5, Chroma.as*5, Chroma.b*5]
        XCTAssertEqual(sut, chromatic)
    }
}
