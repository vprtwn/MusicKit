//
//  Translation.swift
//  MusicKit
//
//  Created by Valentin Radu on 24/12/2017.
//  Copyright © 2017 benzguo. All rights reserved.
//

import Foundation

public enum Numerals: UInt, Equatable {
    case arabic
    case chinese
    public static let all = [Numerals.arabic, .chinese]
}

public enum Language: UInt, Equatable {
    case english
    case japanese
    case korean
    case french
    public static let all = [Language.english, .japanese, .korean, .french]
}

public struct Translation {
    
    /// Chromas, accidentals and numerals are fixed size ordered
    /// arrays of size 7 (diatonic pitch classes names),
    /// 5 (accidentals) and 9 (octaves).
    private let letters:[String]
    private let octaves:[String]
    private let accidentals:[String]
    
    public let language:Language
    public let numerals:Numerals
    public let showNatural:Bool
    
    /// Under normal cicumstances you'd want the following pairs:
    /// .english -> .arabic numerals ->
    /// .french -> .arabic numerals (Vive la France!)
    /// .japanese -> .chinese numerals
    /// .korean -> .chinese numerals
    public init(_ lang:Language, numerals num:Numerals, showNatural nat:Bool = false) {
        letters = [
            .english:   ["C", "D", "E", "F", "G", "A", "B"],
            .french:    ["Do", "Re", "Mi", "Fa", "Sol", "La", "Si"],
            .japanese:  ["ド", "レ", "ミ", "ファ", "ソ", "ラ", "シ"],
            .korean:    ["다", "라", "마", "바", "사", "가", "나"]
            ][lang]!
        octaves = [
            .arabic:    ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
            .chinese:   ["空", "一", "二", "三", "四", "五", "六", "七", "八"]
            ][num]!
        accidentals = ["𝄫", "♭", nat ? "♮" : "", "♯", "𝄪"]
        language = lang
        numerals = num
        showNatural = nat
        assert(letters.count == 7)
        assert(octaves.count == 9)
        assert(accidentals.count == 5)
    }
    
    public func translate(_ letter:LetterName, accidental:Accidental, octave:Int) -> (letter:String, accidental:String, octave:String) {
        let (letter, accidental) = translate(letter, accidental:accidental)
        return (letter: letter,
                accidental: accidental,
                octave: octaves[octave])
    }
    
    public func translate(_ letter:LetterName, accidental:Accidental) -> (letter:String, accidental:String) {
        return (letter: letters[Int(letter.rawValue)],
                accidental: accidentals[Int(accidental.rawValue + 2)])
    }
}

extension Translation:Equatable, Hashable {
    public static func ==(lhs: Translation, rhs: Translation) -> Bool {
        return lhs.language == rhs.language &&
               lhs.numerals == rhs.numerals &&
               lhs.showNatural == rhs.showNatural
    }
    public var hashValue: Int {
        return self.language.hashValue ^ self.numerals.hashValue ^ self.showNatural.hashValue
    }
}
