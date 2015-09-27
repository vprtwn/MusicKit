//
//  KeyboardTouch.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

public struct KeyboardTouch {
    public let pitch: Pitch

    /// Force, normalized to [0, 1.0]
    public var force: CGFloat

    /// Horizontal offset from initial location
    public var xOffset: CGFloat = 0.0

    /// Vertical offset from initial location
    public var yOffset: CGFloat = 0.0

    let initialLocation: CGPoint

    init(pitch: Pitch, force: CGFloat, initialLocation: CGPoint) {
        self.pitch = pitch
        self.force = force
        self.initialLocation = initialLocation
    }
}

// MARK: Equatable
// Note that two touches with the same pitch are considered equal
extension KeyboardTouch: Equatable { }
public func ==(lhs: KeyboardTouch, rhs: KeyboardTouch) -> Bool {
    return lhs.pitch == rhs.pitch
}

// MARK: Hashable
extension KeyboardTouch: Hashable {
    public var hashValue: Int {
        return pitch.hashValue
    }
}