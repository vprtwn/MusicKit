//
//  ViewController.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit
import MusicKit

class ViewController: UIViewController, KeyboardViewDelegate {

    lazy var debugLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    lazy var addedTouches = Set<KeyboardTouch>()
    lazy var changedTouches = Set<KeyboardTouch>()
    lazy var removedTouches = Set<KeyboardTouch>()

    lazy var keyboardView: KeyboardView = {
        let view = KeyboardView()
        view.delegate = self
        return view
    }()
    let instrument = AKInstrument()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        debugLabel.text = "FOOo"
        view.addSubview(debugLabel)
        view.addSubview(keyboardView)
        self.view = view
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        debugLabel.frame = CGRectMake(0, 0, view.bounds.width, 100)
        keyboardView.frame = CGRectMake(0,
            CGRectGetMaxY(debugLabel.frame),
            view.bounds.width,
            view.bounds.height - CGRectGetMaxY(debugLabel.frame))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // debug:
    func debugString(touches: Set<KeyboardTouch>) -> String {
        return touches.reduce("") { (a, r) in
            let suffix = String(format: "(%.1f, (%.1f, %.1f))",
                r.force, r.xOffset, r.yOffset)
            if a == "" {
                return "\(r.pitch) \(suffix))"
            }
            return "\(a), \(r.pitch) \(suffix)"
        }
    }

    func updateLabel() {
        guard keyboardView.activeTouches.count > 0 else {
            debugLabel.text = ""
            addedTouches.removeAll()
            changedTouches.removeAll()
            removedTouches.removeAll()
            return
        }
        debugLabel.text = "added: \(debugString(addedTouches))\nchanged: \(debugString(changedTouches))\nremoved: \(debugString(removedTouches))"
    }

    // MARK: KeyboardViewDelegate
    func keyboardView(keyboard: KeyboardView, addedTouches: Set<KeyboardTouch>) {
        self.addedTouches = addedTouches
        updateLabel()
    }

    func keyboardView(keyboard: KeyboardView, changedTouches: Set<KeyboardTouch>) {
        self.changedTouches = changedTouches
        updateLabel()
    }

    func keyboardView(keyboard: KeyboardView, removedTouches: Set<KeyboardTouch>) {
        self.removedTouches = removedTouches
        updateLabel()
    }

}

