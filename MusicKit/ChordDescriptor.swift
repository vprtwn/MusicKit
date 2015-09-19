//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public struct ChordDescriptor: CustomStringConvertible {
    /// The root of the chord.
    public let root: Chroma

    /// The quality of the chord.
    public let quality: ChordQuality

    /// The lowest note of the chord.
    public let bass: Chroma

    public init(root: Chroma, quality: ChordQuality, bass: Chroma) {
        self.root = root
        self.quality = quality
        self.bass = bass
    }

    public var description: String {
        return "root: \(root), quality: \(quality), bass: \(bass)"
    }
}
