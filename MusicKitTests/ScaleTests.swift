import XCTest
import MusicKit

final class ScaleTests: XCTestCase {
    func testMajor() {
        let sut = Scale.Major(Chroma.C*5)
        XCTAssertEqual(sut,
            [
                Chroma.C*5,
                Chroma.D*5,
                Chroma.E*5,
                Chroma.F*5,
                Chroma.G*5,
                Chroma.A*5,
                Chroma.B*5,
            ])
    }
}
