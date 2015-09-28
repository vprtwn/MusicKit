//
//  KeyboardTouch.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

public struct KeyboardTouch {
    /// The pitch of the containing key
    public let pitch: Pitch

    /// Force, normalized to [0, 1.0]
    public var force: CGFloat

    /// Horizontal offset from initial location
    public var xOffset: CGFloat {
        return currentLocation.x - initialLocation.x
    }

    /// Vertical offset from initial location
    public var yOffset: CGFloat {
        return currentLocation.y - initialLocation.y
    }

    /// The location of the touch in the containing key's coordinate system
    public var currentLocation: CGPoint

    /// The initial location of the touch in the containing key
    public let initialLocation: CGPoint

    /// The size of the containing key
    public let keySize: CGSize

    init(pitch: Pitch, force: CGFloat, initialLocation: CGPoint, keySize: CGSize) {
        self.pitch = pitch
        self.force = force
        self.initialLocation = initialLocation
        self.currentLocation = initialLocation
        self.keySize = keySize
    }
}

// MARK: CustomDebugStringConvertible
extension KeyboardTouch: CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(format: "%@ (%.1f)", pitch.description, force)
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