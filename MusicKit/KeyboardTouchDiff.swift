//
//  KeyboardTouchDiff.swift
//  MusicKit
//
//  Created by Ben Guo on 9/28/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import Foundation

struct KeyboardTouchDiff {

    /// Touches currently within keys
    let touchesWithinKeys: Set<KeyboardTouch>

    /// Touches that have left keys
    let touchesLeavingKeys: Set<KeyboardTouch>

    /// Key views currently being touched, paired with touches
    let keyViewTouchPairs: [(KeyView, KeyboardTouch)]

    /// Key views that have become untouched
    let abandonedKeyViews: [KeyView]

    init(touchesWithinKeys: Set<KeyboardTouch>,
        touchesLeavingKeys: Set<KeyboardTouch>,
        keyViewTouchPairs: [(KeyView, KeyboardTouch)],
        abandonedKeyViews: [KeyView])
    {
        self.touchesWithinKeys = touchesWithinKeys
        self.touchesLeavingKeys = touchesLeavingKeys
        self.keyViewTouchPairs = keyViewTouchPairs
        self.abandonedKeyViews = abandonedKeyViews
    }
}
