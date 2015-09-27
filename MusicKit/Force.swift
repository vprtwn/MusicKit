//
//  Force.swift
//  MusicKit
//
//  Created by Ben Guo on 9/27/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

extension UITouch {
    @available(iOS 9.0, *)
    private var relativeForce: CGFloat {
        return force/maximumPossibleForce
    }
}

extension UIView {
    func forceWithTouch(touch: UITouch) -> CGFloat {
        guard #available(iOS 9.0, *) else {
            return KeyView.defaultForce
        }
        guard self.traitCollection.forceTouchCapability == .Available else {
            return KeyView.defaultForce
        }
        return touch.relativeForce
    }
}