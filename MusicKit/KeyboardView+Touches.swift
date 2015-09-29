//
//  KeyboardView+Touches.swift
//  MusicKit
//
//  Created by Ben Guo on 9/28/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

/// Touch handling
extension KeyboardView {
    
    private func parseTouches(touches: Set<UITouch>) -> KeyboardTouchDiff {
        var touchesWithinKeys = Set<KeyboardTouch>()
        var touchesLeavingKeys = Set<KeyboardTouch>()
        var keyViewTouchPairs = [(KeyView, KeyboardTouch)]()
        var abandonedKeyViews = [KeyView]()
        for key in keyViews {
            for touch in touches {
                let currentLocation = touch.locationInView(keyContainer)
                let previousLocation = touch.previousLocationInView(keyContainer)
                let kbTouch = KeyboardTouch(pitch: key.pitch,
                    force: self.forceWithTouch(touch),
                    initialLocation: touch.locationInView(key),
                    keySize: key.bounds.size)
                if CGRectContainsPoint(key.frame, currentLocation) {
                    touchesWithinKeys.insert(kbTouch)
                    keyViewTouchPairs.append((key, kbTouch))
                }
                else if CGRectContainsPoint(key.frame, previousLocation) {
                    abandonedKeyViews.append(key)
                    touchesLeavingKeys.insert(kbTouch)
                }
            }
        }
        return KeyboardTouchDiff(touchesWithinKeys: touchesWithinKeys,
            touchesLeavingKeys: touchesLeavingKeys,
            keyViewTouchPairs: keyViewTouchPairs,
            abandonedKeyViews: abandonedKeyViews)
    }

    private func updateWithNewTouches(pairs: [(KeyView, KeyboardTouch)]) {
        for (key, touch) in pairs { key.force = touch.force }
    }

    private func updateWithChangedTouches(current: [(KeyView, KeyboardTouch)],
        _ abandoned: [KeyView])
    {
        for (key, touch) in current { key.force = touch.force }
        for key in abandoned { key.force = 0 }
    }

    private func updateWithRemovedTouches(pairs: [(KeyView, KeyboardTouch)]) {
        for (key, _) in pairs { key.force = 0 }
    }

    public override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let diff = parseTouches(touches)
        touchDispatcher.registerNewTouches(diff.touchesWithinKeys)
        updateWithNewTouches(diff.keyViewTouchPairs)
    }

    public override func touchesMoved(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let diff = parseTouches(touches)
        touchDispatcher.registerChangedTouches(diff.touchesWithinKeys,
            diff.touchesLeavingKeys)
        updateWithChangedTouches(diff.keyViewTouchPairs,
            diff.abandonedKeyViews)
    }

    public override func touchesCancelled(touches: Set<UITouch>?,
        withEvent event: UIEvent?)
    {
        guard let touches = touches else { return }
        let diff = parseTouches(touches)
        touchDispatcher.registerRemovedTouches(diff.touchesWithinKeys)
        updateWithRemovedTouches(diff.keyViewTouchPairs)
    }

    public override func touchesEnded(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let diff = parseTouches(touches)
        touchDispatcher.registerRemovedTouches(diff.touchesWithinKeys)
        updateWithRemovedTouches(diff.keyViewTouchPairs)
    }
}