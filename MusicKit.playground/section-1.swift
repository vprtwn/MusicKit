import Cocoa

extension Array {
    func rotate(n: Int) -> [T] {
        let count = self.count
        let index = n % count
        return Array(self[index..<count] + self[0..<index])
    }
}

enum LetterName : String {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"
}

enum Accidental : String {
    case Natural = "♮"
    case Sharp = "♯"
    case Flat = "♭"
    case DoubleSharp = "𝄪"
    case DoubleFlat = "𝄫"
}

struct PitchClass {
    let index : Int
    var names : [(LetterName, Accidental)] {
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

struct Pitch {
    let midiNumber : Int

    var frequency : Float {
        return 440
    }

    var pitchClass : PitchClass {
        return PitchClass(index: (midiNumber)%12)
    }

    var octaveNumber : Int {
        return (Int)(midiNumber - 12)/12
    }

    func noteName(neighbor: LetterName) -> String {
        if let name = pitchClass.names.first {
            let letterName = name.0.rawValue
            let accidental = name.1 == .Natural ? "" : name.1.rawValue
            return "\(letterName)\(accidental)\(self.octaveNumber)"
        }
        else {
            return ""
        }
    }
}

typealias Scale = [Int]
struct Scales {
    static let Chromatic = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    static let Octatonic1 = [2, 1, 2, 1, 2, 1, 2, 1]
    static let Octatonic2 = Octatonic1.rotate(1)
    static let Major = [2, 2, 1, 2, 2, 2, 1]
    static let Dorian = Major.rotate(1)
    static let Phrygian = Major.rotate(2)
    static let Lydian = Major.rotate(3)
    static let Mixolydian = Major.rotate(4)
    static let Minor = Major.rotate(5)
    static let Locrian = Major.rotate(6)
}

//struct PitchCollection : CollectionType {
//    let scale : Scale
//    let firstPitch : Pitch
//
//    func generate() -> GeneratorOf<Pitch> {
//        var midiNumber = firstPitch.midiNumber
//        var degree = 0
//        var length = scale.count
//        return GeneratorOf<Pitch> {
//            midiNumber =  midiNumber + self.scale[degree]
//            degree = (degree + 1)%length
//            return Pitch(midiNumber: midiNumber)
//        }
//    }
//}


var p = Pitch(midiNumber: 21)
print(p.noteName)
p = Pitch(midiNumber: 22)
print(p.noteName)
p = Pitch(midiNumber: 86)
print(p.noteName)






