//
//  KeyView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

extension UITouch {
    @available(iOS 9.0, *)
    private var relativeForce: CGFloat {
        return force/maximumPossibleForce
    }
}

extension UIView {
    private func forceWithTouch(touch: UITouch) -> CGFloat {
        guard #available(iOS 9.0, *) else {
            return KeyView.defaultForce
        }
        guard self.traitCollection.forceTouchCapability == .Available else {
            return KeyView.defaultForce
        }
        return touch.relativeForce
    }
}

class KeyView: UIView {
    /// The default force value if force is unavailable
    static var defaultForce: CGFloat = 0.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }

    func load() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundColor = UIColor.clearColor()
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
