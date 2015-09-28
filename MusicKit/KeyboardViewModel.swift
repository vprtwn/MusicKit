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

    mutating func registerNewTouches(keyTouches: [(KeyView, UITouch)]) {
        var newTouches = Set<KeyboardTouch>()
        for (key, touch) in keyTouches {
            let kbTouch = KeyboardTouch(pitch: key.pitch,
                force: view.forceWithTouch(touch),
                initialLocation: touch.locationInView(key),
                keySize: key.bounds.size)
            newTouches.insert(kbTouch)
            activeTouches.insert(kbTouch)
        }
        if newTouches.count > 0 {
            view.delegate?.keyboardView(view, addedTouches: newTouches)
        }
    }

    mutating func registerChangedTouches(keyTouches: [(KeyView, UITouch)]) {
        var newTouches = Set<KeyboardTouch>()
        var changedTouches = Set<KeyboardTouch>()
        var removedTouches = activeTouches
        for (key, touch) in keyTouches {
            let force = view.forceWithTouch(touch)
            let locationInKey = touch.locationInView(key)

            var matchedExistingTouch = false
            for kbTouch in activeTouches {
                // moved within key
                if kbTouch.pitch == key.pitch {
                    matchedExistingTouch = true

                    var newTouch = kbTouch
                    newTouch.force = force
                    newTouch.currentLocation = locationInKey
                    activeTouches.remove(kbTouch)
                    activeTouches.insert(newTouch)

                    removedTouches.remove(kbTouch)
                    changedTouches.insert(newTouch)
                }
            }
            // moved to new key
            if !matchedExistingTouch {
                let kbTouch = KeyboardTouch(pitch: key.pitch,
                    force: view.forceWithTouch(touch),
                    initialLocation: locationInKey,
                    keySize: key.bounds.size)
                newTouches.insert(kbTouch)
                activeTouches.insert(kbTouch)
            }
        }
        if newTouches.count > 0 {
            view.delegate?.keyboardView(view, addedTouches: newTouches)
        }
        if changedTouches.count > 0 {
            view.delegate?.keyboardView(view, changedTouches: changedTouches)
        }
        if removedTouches.count > 0 {
            view.delegate?.keyboardView(view, removedTouches: removedTouches)
            activeTouches = activeTouches.subtract(removedTouches)
        }
    }

    mutating func registerRemovedTouches(keyTouches: [(KeyView, UITouch)]) {
        var removedTouches = Set<KeyboardTouch>()
        for (key, _) in keyTouches {
            for kbTouch in activeTouches {
                if kbTouch.pitch == key.pitch {
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
