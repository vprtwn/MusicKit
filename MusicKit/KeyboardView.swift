//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

public protocol KeyboardViewDelegate {
    func keyboardView(keyboard: KeyboardView, addedTouches: Set<KeyboardTouch>)

    func keyboardView(keyboard: KeyboardView, changedTouches: Set<KeyboardTouch>)

    func keyboardView(keyboard: KeyboardView, removedTouches: Set<KeyboardTouch>)
}

public class KeyboardView: UIView, UIScrollViewDelegate {
    /// The keyboard's delegate
    public var delegate: KeyboardViewDelegate?

    /// The default force of the keyboard, used on devices without force
    public var defaultForce: CGFloat = 0.5

    /// The keyboard's pitches
    public var pitchSet: PitchSet = Scale.Chromatic(Chroma.C*3).extend(3) {
        didSet {
            updateWithPitches(pitchSet)
            setNeedsLayout()
        }
    }

    /// The keyboard's current active touches
    public var activeTouches = Set<KeyboardTouch>()

    /// White key width (px)
    private lazy var whiteKeyWidth: CGFloat = 20/UIDevice.mmPerPixel
    /// avg black key width / avg white key width
    private lazy var blackKeyRelativeWidth: CGFloat = 13.7/23.5

    private lazy var touchToKeyView = [UITouch: KeyView]()
    private lazy var keyViews = [KeyView]()
    private lazy var keyViewContainer: UIScrollView = {
        let view = UIScrollView()
        view.scrollEnabled = false
        view.userInteractionEnabled = false
        return view
    }()
    private lazy var scrollPad: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }

    func load() {
        updateWithPitches(pitchSet)
        addSubview(keyViewContainer)
        addSubview(scrollPad)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let scrollPadHeight = whiteKeyWidth
        scrollPad.frame = CGRectMake(0, bounds.height - scrollPadHeight,
            bounds.width, scrollPadHeight)
        keyViewContainer.frame = CGRectMake(0, 0,
            bounds.width, CGRectGetMinY(scrollPad.frame))

        var lastMaxX: CGFloat = 0
        for i in 0..<keyViews.count {
            let view = keyViews[i]
            view.frame = CGRectMake(CGFloat(i)*whiteKeyWidth, 0, whiteKeyWidth, bounds.height)
            lastMaxX = CGRectGetMaxX(view.frame)
        }
        keyViewContainer.contentSize = CGSizeMake(lastMaxX, bounds.height)
        scrollPad.contentSize = CGSizeMake(lastMaxX, scrollPad.bounds.height)
    }

    func updateWithPitches(pitches: PitchSet) {
        for keyView in keyViews {
            keyView.removeFromSuperview()
        }
        keyViews.removeAll()
        for pitch in pitchSet {
            let keyView = KeyView()
            keyView.pitch = pitch
            keyViewContainer.addSubview(keyView)
            keyViews.append(keyView)
        }
    }

    // MARK: Touches
    private func updateKeyViewsWithNewOrChangedTouches(touches: Set<UITouch>) {
        for key in keyViews {
            var keyTouched = false
            for touch in touches {
                if CGRectContainsPoint(key.frame, touch.locationInView(touch.view)) {
                    keyTouched = true
                    let force = self.forceWithTouch(touch)
                    key.force = force
                    touchToKeyView[touch] = key
                }
            }
            if !keyTouched {
                key.force = 0
            }
        }
    }

    private func updateKeyViewsWithRemovedTouches(touches: Set<UITouch>) {
        for touch in touches {
            if let key = touchToKeyView[touch] {
                key.force = 0
                touchToKeyView.removeValueForKey(touch)
            }
        }
    }

    private func registerNewTouches(touches: Set<UITouch>) {
        var newTouches = Set<KeyboardTouch>()
        for key in keyViews {
            for touch in touches {
                if CGRectContainsPoint(key.frame, touch.locationInView(touch.view)) {
                    let kbTouch = KeyboardTouch(pitch: key.pitch,
                        force: self.forceWithTouch(touch),
                        initialLocation: touch.locationInView(self))
                    newTouches.insert(kbTouch)
                    activeTouches.insert(kbTouch)
                }
            }
        }
        if newTouches.count > 0 {
            delegate?.keyboardView(self, addedTouches: newTouches)
        }
    }

    private func registerChangedTouches(touches: Set<UITouch>) {
        var newTouches = Set<KeyboardTouch>()
        var changedTouches = Set<KeyboardTouch>()
        var removedTouches = activeTouches
        for key in keyViews {
            for touch in touches {
                if CGRectContainsPoint(key.frame, touch.locationInView(touch.view)) {
                    let force = self.forceWithTouch(touch)
                    let location = touch.locationInView(self)

                    var matchedExistingTouch = false
                    for kbTouch in activeTouches {
                        // moved within key
                        if kbTouch.pitch == key.pitch {
                            matchedExistingTouch = true

                            var newTouch = kbTouch
                            newTouch.force = force
                            newTouch.xOffset = location.x - newTouch.initialLocation.x
                            newTouch.yOffset = location.y - newTouch.initialLocation.y
                            activeTouches.remove(kbTouch)
                            activeTouches.insert(newTouch)

                            removedTouches.remove(kbTouch)
                            changedTouches.insert(newTouch)
                        }
                    }
                    // moved to new key
                    if !matchedExistingTouch {
                        let kbTouch = KeyboardTouch(pitch: key.pitch,
                            force: self.forceWithTouch(touch),
                            initialLocation: touch.locationInView(self))
                        newTouches.insert(kbTouch)
                        activeTouches.insert(kbTouch)
                    }
                }
            }

        }
        if newTouches.count > 0 {
            delegate?.keyboardView(self, addedTouches: newTouches)
        }
        if changedTouches.count > 0 {
            delegate?.keyboardView(self, changedTouches: changedTouches)
        }
        if removedTouches.count > 0 {
            delegate?.keyboardView(self, removedTouches: removedTouches)
            activeTouches = activeTouches.subtract(removedTouches)
        }
    }

    private func registerRemovedTouches(touches: Set<UITouch>) {
        var removedTouches = Set<KeyboardTouch>()
        for touch in touches {
            if let key = touchToKeyView[touch] {
                for kbTouch in activeTouches {
                    if kbTouch.pitch == key.pitch {
                        activeTouches.remove(kbTouch)
                        removedTouches.insert(kbTouch)
                    }
                }
            }
        }
        if removedTouches.count > 0 {
            delegate?.keyboardView(self, removedTouches: removedTouches)
        }
    }

    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        registerNewTouches(touches)
        updateKeyViewsWithNewOrChangedTouches(touches)
    }

    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        registerChangedTouches(touches)
        updateKeyViewsWithNewOrChangedTouches(touches)
    }

    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touches = touches else { return }
        registerRemovedTouches(touches)
        updateKeyViewsWithRemovedTouches(touches)
    }

    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        registerRemovedTouches(touches)
        updateKeyViewsWithRemovedTouches(touches)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        keyViewContainer.contentOffset = scrollView.contentOffset
    }

}
