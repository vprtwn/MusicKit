//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public enum LetterName : String {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"

    static let letters : [LetterName] = [.C, .D, .E, .F, .G, .A, .B]
    public func next() -> LetterName {
        let index : Int = find(LetterName.letters, self)!
        let newIndex = (index + 1) % LetterName.letters.count
        return LetterName.letters[newIndex]
    }

    public func previous() -> LetterName {
        let index : Int = find(LetterName.letters, self)!
        let count = LetterName.letters.count
        let newIndex = (((index - 1)%count) + count)%count
        return LetterName.letters[newIndex]
    }
}
