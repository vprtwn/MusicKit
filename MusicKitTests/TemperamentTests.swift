//
//  TemperamentTests.swift
//  MusicKit_OSXTests
//
//  Created by Valentin Radu on 24/12/2017.
//  Copyright © 2017 benzguo. All rights reserved.
//

import XCTest
import MusicKit

final class TemperamentTests: XCTestCase {
    func testInversion() {
        let temps = [Temperament.just, .equal, .pythagorean]
        for temp in temps {
            // For chroma + some microtonal values
            let microtonals = [0.5, 20.354, 60.3, 100.2943]
            for midi in (0..<128).map({Double($0)}) + microtonals {
                let freq = temp.mtof(midi)
                let result = temp.ftom(freq)
                XCTAssertEqual(midi, result)
            }
        }
    }
    func testMtofSpecificValues() {
        let temps = [Temperament.just, .equal, .pythagorean]
        let input = [
            [60.0, 61.0, 62.0, 63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71], //just
            [60.0, 61.0, 62.0, 63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71], //equal
            [60.0, 61.0, 62.0, 63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71] //pythagorean
        ]
        let output = [
            [261.63, 272.54, 294.33, 313.96, 327.03, 348.83, 367.92, 392.44, 418.60, 436.05, 470.93, 490.55, 523.25], //just
            [261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 369.99, 392.00, 415.30, 440.00, 466.16, 493.88, 523.25], //equal
            [261.62, 275.59, 294.32, 310.05, 331.11, 348.82, 372.50, 392.43, 413.42, 441.49, 465.09, 496.66, 523.25] //pythagorean
        ]
        for (i, t) in input.enumerated() {
            for (j, m) in t.enumerated() {
                let r = temps[i].mtof(m)
                let e = output[i][j]
                let a = (abs(r - e) * 100.0) / 100.0
                XCTAssertEqual(a.rounded(), 0)
            }
        }
    }
    func testEquality() {
        XCTAssertFalse(Temperament.just == Temperament.equal)
        XCTAssertTrue(Temperament.just == Temperament.just)
    }
    func testHashing() {
        let a = Temperament.equal
        let b = Temperament.just
        let c = Temperament([])
        let list = [a, b]
        XCTAssertTrue(list.contains(a))
        XCTAssertTrue(list.contains(b))
        XCTAssertFalse(list.contains(c))
    }
}
