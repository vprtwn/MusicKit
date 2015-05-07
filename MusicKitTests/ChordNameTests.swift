import XCTest
import MusicKit

final class ChordNameTests: XCTestCase {
    func testMajorMinor() {
        var sut : PitchSet = [Chroma.C*0, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "CM"
        XCTAssert(name == "CM")

        sut = [Chroma.E*2, Chroma.G*3, Chroma.C*4, Chroma.G*4]
        name = Chord.name(sut)
        expected = "CM/E"
        XCTAssert(name == "CM/E", "\(name) != \(expected)")
    }
}
