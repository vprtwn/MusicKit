//
//  KeyboardViewTouch.swift
//  MusicKit
//
//  Created by Ben Guo on 10/3/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

extension CGPoint {
    private func offset(offset: CGPoint) -> CGPoint {
        return CGPointMake(self.x + offset.x,
            self.y + offset.y)
    }
}

/// Intermediate representation of a UITouch with resolved locations
struct KeyboardViewTouch {
    let location: CGPoint
    let previousLocation: CGPoint
    let locationInKey: CGPoint
    let force: CGFloat
    var locationIsWithinKey: Bool {
        return CGRectContainsPoint(key.frame, location)
    }
    var previousLocationIsWithinKey: Bool {
        return CGRectContainsPoint(key.frame, previousLocation)
    }
    let key: KeyView

    init(touch: KeyboardViewTouch, offset: CGPoint) {
        location = touch.location.offset(offset)
        previousLocation = touch.previousLocation.offset(offset)
        locationInKey = touch.locationInKey.offset(offset)
        force = touch.force
        key = touch.key
    }

    init(location: CGPoint,
        previousLocation: CGPoint,
        locationInKey: CGPoint,
        force: CGFloat,
        key: KeyView)
    {
        self.location = location
        self.previousLocation = previousLocation
        self.locationInKey = locationInKey
        self.force = force
        self.key = key
    }

    init(touch: UITouch,
        keyContainer: UIView,
        keyView: KeyView,
        keyboardView: KeyboardView)
    {
        location = touch.locationInView(keyContainer)
        previousLocation = touch.previousLocationInView(keyContainer)
        locationInKey = touch.locationInView(keyView)
        force = keyboardView.forceWithTouch(touch)
        self.key = keyView
    }
}

// MARK: Equatable
extension KeyboardViewTouch: Equatable { }
func ==(lhs: KeyboardViewTouch, rhs: KeyboardViewTouch) -> Bool {
    return lhs.location == rhs.location &&
    lhs.previousLocation == rhs.previousLocation &&
    lhs.force == rhs.force &&
    lhs.locationInKey == rhs.locationInKey &&
    lhs.key == rhs.key
}

// MARK: Hashable
extension KeyboardViewTouch: Hashable {
    var hashValue: Int {
        return location.x.hashValue |
            location.y.hashValue |
            previousLocation.x.hashValue |
            previousLocation.y.hashValue |
            force.hashValue |
            key.hashValue
    }
}
