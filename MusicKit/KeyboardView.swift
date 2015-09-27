//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

public class KeyboardView: UIView, UIScrollViewDelegate {
    public var defaultForce: CGFloat = 0.5

    // TODO: make this a PitchSet
    var keyCount: UInt = 10

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
        addSubview(keyViewContainer)
        addSubview(scrollPad)
        for _ in 0..<keyCount {
            let keyView = KeyView()
            keyViewContainer.addSubview(keyView)
            keyViews.append(keyView)
        }
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

    // MARK: Touches
    private func updateWithTouches(touches: Set<UITouch>) {
        for key in keyViews {
            var keyTouched = false
            for touch in touches {
                if CGRectContainsPoint(key.frame, touch.locationInView(touch.view)) {
                    keyTouched = true
                    key.force = self.forceWithTouch(touch)
                    touchToKeyView[touch] = key
                }
            }
            if !keyTouched {
                key.force = 0
            }
        }
    }

    private func removeTouches(touches: Set<UITouch>) {
        for touch in touches {
            if let key = touchToKeyView[touch] {
                key.force = 0
                touchToKeyView.removeValueForKey(touch)
            }
        }
    }

    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        updateWithTouches(touches)
    }

    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        updateWithTouches(touches)
    }

    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touches = touches else { return }
        removeTouches(touches)
    }

    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        removeTouches(touches)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        keyViewContainer.contentOffset = scrollView.contentOffset
    }

}
