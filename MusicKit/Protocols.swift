//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public protocol Transposable {
    /// Returns self transposed by the given semitone distance
    func transpose(_ semitones: Float) -> Self
}
