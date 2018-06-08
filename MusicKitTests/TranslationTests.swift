//
//  TranslationTests.swift
//  MusicKit
//
//  Created by Valentin Radu on 25/12/2017.
//  Copyright © 2017 benzguo. All rights reserved.
//

import XCTest
import MusicKit

class TranslationTests: XCTestCase {
    func testTranslateSpecificValues() {
        let translations = [Translation(.english, numerals:.arabic),
                            Translation(.french, numerals:.arabic),
                            Translation(.korean, numerals:.chinese),
                            Translation(.japanese, numerals:.chinese)]
        
        let pitches = [(LetterName.c, Accidental.doubleFlat, 4),
                       (LetterName.f, Accidental.natural, 4),
                       (LetterName.a, Accidental.sharp, 5)]
        
        let expectations = [["C𝄫4", "F4", "A♯5"],
                            ["Do𝄫4", "Fa4", "La♯5"],
                            ["다𝄫四", "바四", "가♯五"],
                            ["ド𝄫四", "ファ四", "ラ♯五"]]
        
        for (i, t) in translations.enumerated() {
            for (j, p) in pitches.enumerated() {
                let r = t.translate(p.0, accidental: p.1, octave: p.2)
                let name = "\(r.letter.description)" + "\(r.accidental.description)" + "\(r.octave.description)"
                XCTAssertEqual(name, expectations[i][j])
            }
        }
    }
    func testEquality() {
        let a = Translation(.english, numerals:.arabic)
        let b = Translation(.english, numerals:.arabic)
        XCTAssertTrue(a == b)
    }
    func testHashing() {
        let a = Translation(.english, numerals:.arabic)
        let b = Translation(.english, numerals:.arabic)
        let c = Translation(.english, numerals:.chinese)
        let list = [a]
        XCTAssertTrue(list.contains(a))
        XCTAssertTrue(list.contains(b))
        XCTAssertFalse(list.contains(c))
    }
}
