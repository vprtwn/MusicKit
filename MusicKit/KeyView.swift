//
//  KeyView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

class KeyView: UIView {
    /// The default force value if force is unavailable
    // TODO: move to KeyboardView
    static var defaultForce: CGFloat = 0.5

    /// The color of the key view when force = 1.0
    var touchColor = UIColor.blueColor() {
        didSet {
            foregroundView.backgroundColor = touchColor
        }
    }

    /// The current force the view is receiving
    var force: CGFloat = 0 {
        didSet {
            foregroundView.backgroundColor = touchColor.colorWithAlphaComponent(force)
        }
    }

    private lazy var foregroundView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }

    func load() {
        self.addSubview(foregroundView)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundColor = UIColor.clearColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        foregroundView.frame = bounds
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let force = self.forceWithTouch(touch)
        self.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(force)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let force = self.forceWithTouch(touch)
        self.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(force)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.backgroundColor = UIColor.clearColor()
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.backgroundColor = UIColor.clearColor()
    }

}
