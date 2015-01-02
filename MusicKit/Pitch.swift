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

public struct PitchClass : Printable {
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

    public var description : String {
        if let first = self.names.first {
            let letter = first.0.rawValue
            let accidental = first.1.rawValue
            return "\(letter)\(accidental)"
        }
        else {
            return ""
        }

    }
}

public struct Pitch : Printable {
    public static func mtof(midiNumber: Float) -> Float {
        let exponent = Double((Float(midiNumber) - 69.0)/12.0)
        let freq = pow(Double(2), exponent)*MusicKit.concertA
        return Float(freq)
    }

    public static func ftom(frequency: Float) -> Float {
        let octaves = log2(Double(frequency) / MusicKit.concertA)
        return Float(69.0 + (12.0*octaves))
    }

    public let midiNumber : Float

    public init(midiNumber: Float) {
        self.midiNumber = midiNumber
    }

    public init(frequency: Float) {
        self.midiNumber = Pitch.ftom(frequency)
    }

    public var frequency : Float {
        return Pitch.mtof(self.midiNumber)
    }

    var hasName : Bool {
        return self.midiNumber - floor(self.midiNumber) == 0
    }

    public var pitchClass : PitchClass? {
        if self.hasName {
            return PitchClass(index: UInt(self.midiNumber)%12)
        }
        return nil
    }

    public var octaveNumber : Int {
        return Int((self.midiNumber - 12.0)/12.0)
    }

    public var noteName : String {
        if pitchClass == nil {
            return ""
        }
        if let name = pitchClass!.names.first {
            let letterName = name.0.rawValue
            let accidental = name.1 == .Natural ? "" : name.1.rawValue
            return "\(letterName)\(accidental)\(octaveNumber)"
        }
        else {
            return ""
        }
    }

    public var description : String {
        return "\(noteName): \(frequency)Hz"
    }
}