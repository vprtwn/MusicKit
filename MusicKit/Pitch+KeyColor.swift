//
//  Pitch+KeyColor.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import Foundation

enum KeyColor {
    case White
    case Black
    case Other
}

extension Pitch {
    var keyColor: KeyColor {
        if let chroma = chroma {
            switch chroma {
            case .C, .D, .E, .F, .G, .A, .B:
                return .White
            case .Cs, .Ds, .Fs, .Gs, .As:
                return .Black
            }
        }
        return .Other
    }
}