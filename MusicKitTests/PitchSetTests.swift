import XCTest
import MusicKit

final class PitchSetTests: XCTestCase {
    func testInitWithDuplicate() {
        let ps1 : PitchSet = [Chroma.C*2, Chroma.C*2]
        XCTAssertEqual(ps1.count, 1)
        let ps2 = PitchSet(pitches: Chroma.C*2, Chroma.C*2)
        XCTAssertEqual(ps2.count, 1)
        let ps3 = PitchSet([Chroma.C*2, Chroma.C*2])
        XCTAssertEqual(ps3.count, 1)
    }

    func testInsertDuplicate() {
        var ps : PitchSet = [Chroma.C*2]
        XCTAssertEqual(ps.count, 1)
        ps.insert(Chroma.C*2)
        XCTAssertEqual(ps.count, 1)
        ps.insert([Chroma.C*2, Chroma.C*3])
        XCTAssertEqual(ps.count, 2)
    }

    func testSliceable() {
        let ps : PitchSet = [Chroma.C*2, Chroma.C*3, Chroma.C*4]
        let slice = ps[0...1]
        XCTAssertEqual(PitchSet(slice),
            PitchSet([Chroma.C*2, Chroma.C*3]))
    }

}
