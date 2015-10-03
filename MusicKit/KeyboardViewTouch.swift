//
//  KeyboardViewTouch.swift
//  MusicKit
//
//  Created by Ben Guo on 10/3/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

/// Intermediate representation of a UITouch with resolved locations
struct KeyboardViewTouch {
    let location: CGPoint
    let previousLocation: CGPoint
    let locationInKey: CGPoint
    let force: CGFloat
    let locationIsWithinKey: Bool
    let previousLocationIsWithinKey: Bool
    let key: KeyView

    init(touch: UITouch,
        keyContainer: UIView,
        keyView: KeyView,
        keyboardView: KeyboardView)
    {
        location = touch.locationInView(keyContainer)
        previousLocation = touch.previousLocationInView(keyContainer)
        locationInKey = touch.locationInView(keyView)
        if CGRectContainsPoint(keyView.frame, location) {
            locationIsWithinKey = true
        }
        else {
            locationIsWithinKey = false
        }
        if CGRectContainsPoint(keyView.frame, previousLocation) {
            previousLocationIsWithinKey = true
        }
        else {
            previousLocationIsWithinKey = false
        }
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
    lhs.locationIsWithinKey == rhs.locationIsWithinKey &&
    lhs.previousLocationIsWithinKey == rhs.previousLocationIsWithinKey &&
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
            locationIsWithinKey.hashValue |
            previousLocationIsWithinKey.hashValue |
            key.hashValue
    }
}
