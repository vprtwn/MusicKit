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

    /// The key's pitch
    var pitch: Pitch = Chroma.C*4 {
        didSet {
            debugLabel.text = pitch.description
            debugLabel.sizeToFit()
            setNeedsLayout()
        }
    }

    // TODO: remove
    private var debugLabel = UILabel()

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
        self.addSubview(debugLabel)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundColor = UIColor.clearColor()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        foregroundView.frame = bounds
        debugLabel.center = CGPointMake(CGRectGetMidX(bounds),
            CGRectGetMidY(bounds))
    }
}
