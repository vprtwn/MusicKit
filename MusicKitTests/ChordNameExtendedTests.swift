import XCTest
import MusicKit

final class ChordNameExtendedTests: XCTestCase {
    func testTriadSlashChords() {
        var sut : PitchSet = [Chroma.Cs*0, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "CM/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.Fs*0, Chroma.Ds*2, Chroma.G*3, Chroma.C*4]
        name = Chord.name(sut)
        expected = "Cm/F♯"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }

    func testTetradSlashChords() {
        var sut : PitchSet = [Chroma.Cs*0, Chroma.E*2, Chroma.G*3, Chroma.C*4]
        var name = Chord.name(sut)
        var expected = "CM/C♯"
        XCTAssert(name == expected, "\(name) != \(expected)")

        sut = [Chroma.Fs*0, Chroma.Ds*2, Chroma.G*3, Chroma.C*4]
        name = Chord.name(sut)
        expected = "Cm/F♯"
        XCTAssert(name == expected, "\(name) != \(expected)")
    }
}
