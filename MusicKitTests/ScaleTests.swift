import XCTest
import MusicKit

final class ScaleTests: XCTestCase {
    func testMajor() {
        let sut = Scale.Major(Chroma.C*5)
        let major : PitchSet = [Chroma.C*5, Chroma.D*5, Chroma.E*5, Chroma.F*5,
            Chroma.G*5, Chroma.A*5, Chroma.B*5]
        XCTAssertEqual(sut, major)
    }

    func testChromatic() {
        let sut = Scale.Chromatic(Chroma.C*5)
        let chromatic : PitchSet = [Chroma.C*5, Chroma.Cs*5, Chroma.D*5,
            Chroma.Ds*5, Chroma.E*5, Chroma.F*5, Chroma.Fs*5, Chroma.G*5,
            Chroma.Gs*5, Chroma.A*5, Chroma.As*5, Chroma.B*5]
        XCTAssertEqual(sut, chromatic)
    }
}
