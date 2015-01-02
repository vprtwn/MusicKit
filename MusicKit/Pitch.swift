//  Copyright (c) 2015 Ben Guo. All rights reserved.

public enum LetterName : String {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"
}

public enum Accidental : String {
    case Natural = "♮"
    case Sharp = "♯"
    case Flat = "♭"
    case DoubleSharp = "𝄪"
    case DoubleFlat = "𝄫"
}

public typealias PitchClassName = (LetterName, Accidental)

public struct PitchClass {
    public let index : UInt
    public init(index: UInt) {
        self.index = index
    }

    public var names : [PitchClassName] {
        switch self.index {
        case 0:
            return [(.C, .Natural), (.B, .Sharp)]
        case 1:
            return [(.D, .Flat), (.C, .Sharp)]
        case 2:
            return [(.D, .Natural)]
        case 3:
            return [(.E, .Flat), (.D, .Sharp)]
        case 4:
            return [(.E, .Natural)]
        case 5:
            return [(.F, .Natural), (.E, .Sharp)]
        case 6:
            return [(.F, .Sharp), (.G, .Flat)]
        case 7:
            return [(.G, .Natural)]
        case 8:
            return [(.A, .Flat), (.G, .Sharp)]
        case 9:
            return [(.A, .Natural)]
        case 10:
            return [(.B, .Flat), (.A, .Sharp)]
        case 11:
            return [(.B, .Natural), (.C, .Flat)]
        default:
            return []
        }
    }
}

public struct Pitch {
    public let midiNumber : UInt
    public init(midiNumber: UInt) {
        self.midiNumber = midiNumber
    }

    public var frequency : Float {
        let exponent = Double((Float(midiNumber) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    public var pitchClass : PitchClass {
        return PitchClass(index: midiNumber%12)
    }

    public var octaveNumber : Int {
        return (midiNumber - 12)/12
    }

    public var noteName : String {
        if let name = pitchClass.names.first {
            let letterName = name.0.rawValue
            let accidental = name.1 == .Natural ? "" : name.1.rawValue
            return "\(letterName)\(accidental)\(octaveNumber)"
        }
        else {
            return ""
        }
    }
}