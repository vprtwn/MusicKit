//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct MusicKit {
    /// The global value of concert A
    public static var concertA: Double = 440.0
    /// The global temperament
    public static var temperament = Temperament.equal
    /// The global base midi note. Used to map frequency to
    /// midi notes, usually 69 (A4 in midi standard, which
    /// normally corresponds to 440.0Hz concert A)
    public static var baseMidiNote = 69.0
}
