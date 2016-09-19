//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

public protocol KeyboardViewDelegate: class {
    func keyboardView(_ keyboard: KeyboardView, addedTouches: Set<KeyboardTouch>)
    func keyboardView(_ keyboard: KeyboardView, changedTouches: Set<KeyboardTouch>)
    func keyboardView(_ keyboard: KeyboardView, removedTouches: Set<KeyboardTouch>)
}

open class KeyboardView: UIView, UIScrollViewDelegate {

    /// The keyboard view's delegate
    open var delegate: KeyboardViewDelegate?

    /// The default force of the keyboard, used on devices without force
    open var defaultForce: CGFloat = 0.5

    /// The keyboard's pitches
    open var pitchSet: PitchSet = Scale.Chromatic(Chroma.c*3).extend(3) {
        didSet {
            updateWithPitches(pitchSet)
            setNeedsLayout()
        }
    }

    /// The keyboard's current active touches
    open var activeTouches: Set<KeyboardTouch> {
        return touchDispatcher.activeTouches
    }

    /// The width of white keys (mm)
    open var whiteKeyWidth: CGFloat = 20 {
        didSet { setNeedsLayout() }
    }

    /// The height of the scroll pad (mm)
    open var scrollPadHeight: CGFloat = 15 {
        didSet { setNeedsLayout() }
    }

    /// The width of black keys relative to white keys
    open var blackKeyRelativeWidth: CGFloat = 13.7/23.5

    fileprivate var blackKeyWidthPx: CGFloat {
        return whiteKeyWidthPx*blackKeyRelativeWidth
    }

    lazy var touchDispatcher: KeyboardViewTouchDispatcher = {
        return KeyboardViewTouchDispatcher(view: self)
        }()

    fileprivate var whiteKeyWidthPx: CGFloat {
        return whiteKeyWidth/UIDevice.mmPerPixel
    }

    fileprivate var scrollPadHeightPx: CGFloat {
        return scrollPadHeight/UIDevice.mmPerPixel
    }

    lazy var keyViews = [KeyView]()
    lazy var keyContainer: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        return view
    }()

    fileprivate lazy var scrollPad: UIScrollView = {
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
        isMultipleTouchEnabled = true
        updateWithPitches(pitchSet)
        addSubview(keyContainer)
        addSubview(scrollPad)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        scrollPad.frame = CGRect(x: 0, y: bounds.height - scrollPadHeightPx,
            width: bounds.width, height: scrollPadHeightPx)
        keyContainer.frame = CGRect(x: 0, y: 0,
            width: bounds.width, height: scrollPad.frame.minY)

        var lastFrame: CGRect? = nil
        var lastColor: KeyColor? = nil
        let whiteHeight = bounds.height - scrollPadHeightPx
        let blackHeight = round(whiteHeight/2.0)

        for i in 0..<keyViews.count {
            let view = keyViews[i]
            var frame: CGRect
            if view.pitch.keyColor == .black {
                if let lastFrame = lastFrame , lastColor == .white {
                    let x = lastFrame.maxX - round(blackKeyWidthPx/2.0)
                    frame = CGRect(x: x, y: 0, width: blackKeyWidthPx, height: blackHeight)
                }
                else if let lastFrame = lastFrame , lastColor == .black {
                    let x = lastFrame.maxX
                    frame = CGRect(x: x, y: 0, width: blackKeyWidthPx, height: blackHeight)
                }
                else {
                    frame = CGRect(x: 0, y: 0, width: blackKeyWidthPx, height: blackHeight)
                }
                lastColor = .black
            }
            else {
                if let lastFrame = lastFrame , lastColor == .white {
                    let x = lastFrame.maxX
                    frame = CGRect(x: x, y: 0, width: whiteKeyWidthPx, height: whiteHeight)
                }
                else if let lastFrame = lastFrame , lastColor == .black {
                    let x = lastFrame.minX + round(blackKeyWidthPx/2.0)
                    frame = CGRect(x: x, y: 0, width: whiteKeyWidthPx, height: whiteHeight)
                }
                else {
                    frame = CGRect(x: 0, y: 0, width: whiteKeyWidthPx, height: whiteHeight)
                }
                // Other = same position as White
                lastColor = .white
            }
            view.frame = frame
            lastFrame = frame
        }
        if let frame = lastFrame {
            let lastMaxX = frame.maxX
            keyContainer.contentSize = CGSize(width: lastMaxX,
                height: keyContainer.bounds.height)
            scrollPad.contentSize = CGSize(width: lastMaxX, height: scrollPad.bounds.height)
        }
    }

    func updateWithPitches(_ pitches: PitchSet) {
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
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        keyContainer.contentOffset = scrollView.contentOffset
    }
}
