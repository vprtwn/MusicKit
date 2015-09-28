//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

public protocol KeyboardViewDelegate: class {
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
            viewModel.pitchSet = pitchSet
            updateWithPitches(pitchSet)
            setNeedsLayout()
        }
    }

    /// The keyboard's current active touches
    public var activeTouches: Set<KeyboardTouch> {
        return viewModel.activeTouches
    }

    private lazy var viewModel: KeyboardViewModel = {
        return KeyboardViewModel(view: self)
    }()

    /// White key width (px)
    private lazy var whiteKeyWidth: CGFloat = 20/UIDevice.mmPerPixel
    /// avg black key width / avg white key width
    private lazy var blackKeyRelativeWidth: CGFloat = 13.7/23.5

    private lazy var keyViews = [KeyView]()
    private lazy var keyContainer: UIScrollView = {
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
        multipleTouchEnabled = true
        updateWithPitches(pitchSet)
        addSubview(keyContainer)
        addSubview(scrollPad)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let scrollPadHeight = whiteKeyWidth
        scrollPad.frame = CGRectMake(0, bounds.height - scrollPadHeight,
            bounds.width, scrollPadHeight)
        keyContainer.frame = CGRectMake(0, 0,
            bounds.width, CGRectGetMinY(scrollPad.frame))

        var lastMaxX: CGFloat = 0
        for i in 0..<keyViews.count {
            let view = keyViews[i]
            view.frame = CGRectMake(CGFloat(i)*whiteKeyWidth, 0, whiteKeyWidth, bounds.height)
            lastMaxX = CGRectGetMaxX(view.frame)
        }
        keyContainer.contentSize = CGSizeMake(lastMaxX, bounds.height)
        scrollPad.contentSize = CGSizeMake(lastMaxX, scrollPad.bounds.height)
    }

    func updateWithPitches(pitches: PitchSet) {
        for keyView in keyViews {
            keyView.removeFromSuperview()
        }
        keyViews.removeAll()
        for pitch in pitchSet {
            let keyView = KeyView(pitch: pitch)
            keyContainer.addSubview(keyView)
            keyViews.append(keyView)
        }
    }

    // MARK: Touches
    private func parsedTouches(touches: Set<UITouch>) -> ([(KeyView, UITouch)], [KeyView]) {
        var keyTouches = [(KeyView, UITouch)]()
        var removedKeys = [KeyView]()
        for key in keyViews {
            for touch in touches {
                let currentLocation = touch.locationInView(keyContainer)
                let previousLocation = touch.previousLocationInView(keyContainer)
                if CGRectContainsPoint(key.frame, currentLocation) {
                    keyTouches.append((key, touch))
                }
                else if CGRectContainsPoint(key.frame, previousLocation) {
                    removedKeys.append(key)
                }
            }
        }
        return (keyTouches, removedKeys)
    }

    private func updateWithNewTouches(keyTouches: [(KeyView, UITouch)]) {
        for (key, touch) in keyTouches {
            let force = self.forceWithTouch(touch)
            key.force = force
        }
    }

    private func updateWithChangedTouches(keyTouches: [(KeyView, UITouch)],
        removedKeys: [KeyView])
    {
        for (key, touch) in keyTouches {
            let force = self.forceWithTouch(touch)
            key.force = force
        }
        for key in removedKeys {
            key.force = 0
        }
    }

    private func updateWithRemovedTouches(keyTouches: [(KeyView, UITouch)]) {
        for (key, _) in keyTouches {
            key.force = 0
        }
    }

    public override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let (keyTouches, _) = parsedTouches(touches)
        viewModel.registerNewTouches(keyTouches)
        updateWithNewTouches(keyTouches)
    }

    public override func touchesMoved(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let (keyTouches, removedKeys) = parsedTouches(touches)
        viewModel.registerChangedTouches(keyTouches)
        updateWithChangedTouches(keyTouches, removedKeys: removedKeys)
    }

    public override func touchesCancelled(touches: Set<UITouch>?,
        withEvent event: UIEvent?)
    {
        guard let touches = touches else { return }
        let (keyTouches, _) = parsedTouches(touches)
        viewModel.registerRemovedTouches(keyTouches)
        updateWithRemovedTouches(keyTouches)
    }

    public override func touchesEnded(touches: Set<UITouch>,
        withEvent event: UIEvent?)
    {
        let (keyTouches, _) = parsedTouches(touches)
        viewModel.registerRemovedTouches(keyTouches)
        updateWithRemovedTouches(keyTouches)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        keyContainer.contentOffset = scrollView.contentOffset
    }

}
