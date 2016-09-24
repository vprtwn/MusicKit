//
//  Pitch+KeyColor.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import Foundation

enum KeyColor {
    case white
    case black
    case other
}

extension Pitch {
    var keyColor: KeyColor {
        if let chroma = chroma {
            switch chroma {
            case .c, .d, .e, .f, .g, .a, .b:
                return .white
            case .cs, .ds, .fs, .gs, .as:
                return .black
            }
        }
        return .other
    }
}
