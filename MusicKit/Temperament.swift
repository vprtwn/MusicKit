//
//  Temperament.swift
//  MusicKit_OSX
//
//  Created by Valentin Radu on 24/12/2017.
//  Copyright © 2017 benzguo. All rights reserved.
//

public struct Temperament: Equatable, Hashable {
    
    public static let just = Temperament([1.0000, 1.0417, 1.1250, 1.2000,
                                          1.2500, 1.3333, 1.4063, 1.5000,
                                          1.6000, 1.6667, 1.8000, 1.8750])
    public static let equal = Temperament([1.0000, 1.0594, 1.1224, 1.1892,
                                           1.2599, 1.3348, 1.4142, 1.4983,
                                           1.5874, 1.6817, 1.7818, 1.8877])
    public static let pythagorean = Temperament([1.0000, 1.0534, 1.1250, 1.1851,
                                                 1.2656, 1.3333, 1.4238, 1.5000,
                                                 1.5802, 1.6875, 1.7777, 1.8984])
    
    /// A 12 elements ordered fixed sized array
    /// containing values between 1 and 2 that
    /// skew the normal (equal) temperament
    public let ratios:[Double]
    public init(_ r:[Double]) {
        ratios = r
    }
    
    /// MIDI number to frequency
    public func mtof(_ midi: Double) -> Double {
        assert(midi < 128 && midi >= 0)
        var ratios = self.ratios
        // We need to close the ratios (add 2) in order to
        // find the last one (which should be always smaller than 2)
        ratios.append(2.0)
        let offset = midi.truncatingRemainder(dividingBy: 12.0)
        let base = midi - offset
        let freq = MusicKit.concertA * pow(2.0, (base - MusicKit.baseMidiNote) / 12.0)
        let dev = offset.truncatingRemainder(dividingBy: 1)
        let a = ratios[Int(offset - dev)]
        let b = ratios[Int(offset - dev) + 1]
        let ratio = a + dev * (b - a)
        assert(ratio >= 1)
        return freq * ratio
    }
    
    /// Frequency to MIDI number
    public func ftom(_ freq: Double) -> Double {
        let base = floor(log(freq / mtof(0)) / log(2)) * 12.0
        var ratios = self.ratios
        // We need to close the ratios (add 2) in order to
        // find the last one (which should be always smaller than 2)
        ratios.append(2.0)
        var midi = Double.infinity
        // This is the deviation from the chroma value. So, this
        // function will output microtonal midi values (e.g 60.24)
        // Probably there's a specific function that describes best
        // the intermpolation for each temperament, but for now,
        // we will simply use a linear interpolation
        var dev = 0.0
        for (i, _) in ratios.enumerated() {
            if i == 0 {continue}
            let f = MusicKit.concertA * pow(2.0, (base - MusicKit.baseMidiNote) / 12.0)
            let sf = ratios[i - 1] * f
            let ef = ratios[i] * f
            // Should be ordered
            assert(sf < ef)
            if  sf <= freq && ef > freq  {
                midi = base + Double(i - 1)
                dev = (freq - sf) / (ef - sf)
                break
            }
            else {
                continue
            }
        }
        assert(midi != Double.infinity)
        return midi + dev
    }
    
    public static func ==(lhs: Temperament, rhs: Temperament) -> Bool {
        return lhs.ratios == rhs.ratios
    }
    
    public var hashValue: Int {
        if let ratio = ratios.first {
            return ratios.dropFirst().reduce(ratio.hashValue, {
                sum, value in
                return sum ^ value.hashValue
            })
        }
        else {
            return 0
        }
    }
}
