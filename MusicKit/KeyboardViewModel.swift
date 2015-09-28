//
//  KeyboardViewModel.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

struct KeyboardViewModel {
    var view: KeyboardView

    var pitchSet: PitchSet = PitchSet([])

    /// The keyboard's current active touches
    var activeTouches = Set<KeyboardTouch>()

    init(view: KeyboardView) {
        self.view = view
    }

    mutating func registerNewTouches(touches: Set<KeyboardTouch>) {
        activeTouches = activeTouches.union(touches)
        if touches.count > 0 {
            view.delegate?.keyboardView(view, addedTouches: touches)
        }
    }

    mutating func registerChangedTouches(touches: Set<KeyboardTouch>,
        removedKeys: [KeyView])
    {
        var newTouches = Set<KeyboardTouch>()
        var changedTouches = Set<KeyboardTouch>()
        var removedTouches = Set<KeyboardTouch>()
        for touch in touches {
            var matchedExistingTouch = false
            for kbTouch in activeTouches {
                // moved within key: update existing touch
                if kbTouch.pitch == touch.pitch {
                    matchedExistingTouch = true
                    activeTouches.remove(kbTouch)
                    activeTouches.insert(touch)
                    changedTouches.insert(touch)
                }
            }
            // moved to new key: add new touch
            if !matchedExistingTouch {
                newTouches.insert(touch)
            }
        }
        // moved out of key: remove touch
        for key in removedKeys {
            for kbTouch in activeTouches {
                if kbTouch.pitch == key.pitch {
                    removedTouches.insert(kbTouch)
                }
            }
        }
        // normalize
        removedTouches = removedTouches.subtract(newTouches)
        removedTouches = removedTouches.subtract(changedTouches)

        // update active touches
        activeTouches = activeTouches.union(newTouches)
        activeTouches = activeTouches.subtract(removedTouches)

        // inform delegate
        if newTouches.count > 0 {
            view.delegate?.keyboardView(view, addedTouches: newTouches)
        }
        if changedTouches.count > 0 {
            view.delegate?.keyboardView(view, changedTouches: changedTouches)
        }
        if removedTouches.count > 0 {
            view.delegate?.keyboardView(view, removedTouches: removedTouches)
        }
    }

    mutating func registerRemovedTouches(touches: Set<KeyboardTouch>) {
        var removedTouches = Set<KeyboardTouch>()
        for touch in touches {
            for kbTouch in activeTouches {
                if kbTouch.pitch == touch.pitch {
                    activeTouches.remove(kbTouch)
                    removedTouches.insert(kbTouch)
                }
            }
        }
        if removedTouches.count > 0 {
            view.delegate?.keyboardView(view, removedTouches: removedTouches)
        }
    }
}
