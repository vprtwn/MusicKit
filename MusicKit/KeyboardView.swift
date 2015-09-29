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
            updateWithPitches(pitchSet)
            setNeedsLayout()
        }
    }

    /// The keyboard's current active touches
    public var activeTouches: Set<KeyboardTouch> {
        return touchDispatcher.activeTouches
    }

    /// The height of the scroll pad
    public var scrollPadHeight: CGFloat = 128.0 {
        didSet { setNeedsLayout() }
    }

    /// The width of white keys (mm)
    public var whiteKeyWidth: CGFloat = 20 {
        didSet { setNeedsLayout() }
    }

    /// The width of black keys relative to white keys
    public var blackKeyRelativeWidth: CGFloat = 13.7/23.5

    lazy var touchDispatcher: KeyboardViewTouchDispatcher = {
        return KeyboardViewTouchDispatcher(view: self)
        }()

    private var whiteKeyWidthPx: CGFloat {
        return whiteKeyWidth/UIDevice.mmPerPixel
    }

    lazy var keyViews = [KeyView]()
    lazy var keyContainer: UIScrollView = {
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
        scrollPadHeight = whiteKeyWidthPx
        updateWithPitches(pitchSet)
        addSubview(keyContainer)
        addSubview(scrollPad)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let scrollPadHeight = whiteKeyWidthPx
        scrollPad.frame = CGRectMake(0, bounds.height - scrollPadHeight,
            bounds.width, scrollPadHeight)
        keyContainer.frame = CGRectMake(0, 0,
            bounds.width, CGRectGetMinY(scrollPad.frame))

        var lastMaxX: CGFloat = 0
        for i in 0..<keyViews.count {
            let view = keyViews[i]
            view.frame = CGRectMake(CGFloat(i)*whiteKeyWidthPx,
                0, whiteKeyWidthPx, bounds.height - scrollPadHeight)
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

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        keyContainer.contentOffset = scrollView.contentOffset
    }
}
