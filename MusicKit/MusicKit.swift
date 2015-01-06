//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

extension Array {
    func rotate(n: Int) -> [T] {
        let count = self.count
        let index = (n >= 0) ? n % count : count - (abs(n) % count)
        return Array(self[index..<count] + self[0..<index])
    }
}

public struct MusicKit {
    public static var concertA : Double = 440.0
}
