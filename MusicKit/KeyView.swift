//
//  KeyView.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit

class KeyView: UIView {
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
}
