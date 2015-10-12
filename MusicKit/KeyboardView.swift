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

    /// The keyboard view's delegate
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

    /// The width of white keys (mm)
    public var whiteKeyWidth: CGFloat = 20 {
        didSet { setNeedsLayout() }
    }

    /// The height of the scroll pad (mm)
    public var scrollPadHeight: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// The width of black keys relative to white keys
    public var blackKeyRelativeWidth: CGFloat = 13.7/23.5

    private var blackKeyWidthPx: CGFloat {
        return whiteKeyWidthPx*blackKeyRelativeWidth
    }

    lazy var touchDispatcher: KeyboardViewTouchDispatcher = {
        return KeyboardViewTouchDispatcher(view: self)
        }()

    private var whiteKeyWidthPx: CGFloat {
        return whiteKeyWidth/UIDevice.mmPerPixel
    }

    private var scrollPadHeightPx: CGFloat {
        return scrollPadHeight/UIDevice.mmPerPixel
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
    var activeKVTouches = Set<KeyboardViewTouch>()

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

        scrollPad.frame = CGRectMake(0, bounds.height - scrollPadHeightPx,
            bounds.width, scrollPadHeightPx)
        keyContainer.frame = CGRectMake(0, 0,
            bounds.width, CGRectGetMinY(scrollPad.frame))

        var lastFrame: CGRect? = nil
        var lastColor: KeyColor? = nil
        let whiteHeight = bounds.height - scrollPadHeightPx
        let blackHeight = round(whiteHeight/2.0)

        for i in 0..<keyViews.count {
            let view = keyViews[i]
            var frame: CGRect
            if view.pitch.keyColor == .Black {
                if let lastFrame = lastFrame where lastColor == .White {
                    let x = CGRectGetMaxX(lastFrame) - round(blackKeyWidthPx/2.0)
                    frame = CGRectMake(x, 0, blackKeyWidthPx, blackHeight)
                }
                else if let lastFrame = lastFrame where lastColor == .Black {
                    let x = CGRectGetMaxX(lastFrame)
                    frame = CGRectMake(x, 0, blackKeyWidthPx, blackHeight)
                }
                else {
                    frame = CGRectMake(0, 0, blackKeyWidthPx, blackHeight)
                }
                lastColor = .Black
            }
            else {
                if let lastFrame = lastFrame where lastColor == .White {
                    let x = CGRectGetMaxX(lastFrame)
                    frame = CGRectMake(x, 0, whiteKeyWidthPx, whiteHeight)
                }
                else if let lastFrame = lastFrame where lastColor == .Black {
                    let x = CGRectGetMinX(lastFrame) + round(blackKeyWidthPx/2.0)
                    frame = CGRectMake(x, 0, whiteKeyWidthPx, whiteHeight)
                }
                else {
                    frame = CGRectMake(0, 0, whiteKeyWidthPx, whiteHeight)
                }
                // Other = same position as White
                lastColor = .White
            }
            view.frame = frame
            lastFrame = frame
        }
        if let frame = lastFrame {
            let lastMaxX = CGRectGetMaxX(frame)
            keyContainer.contentSize = CGSizeMake(lastMaxX,
                keyContainer.bounds.height)
            scrollPad.contentSize = CGSizeMake(lastMaxX, scrollPad.bounds.height)
        }
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
