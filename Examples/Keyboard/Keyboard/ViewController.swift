//
//  ViewController.swift
//  Keyboard
//
//  Created by Ben Guo on 9/25/15.
//  Copyright © 2015 MusicKit. All rights reserved.
//

import UIKit
import MusicKit

class ViewController: UIViewController {

    lazy var keyboardView: KeyboardView = KeyboardView()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(keyboardView)
        self.view = view
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keyboardView.frame = view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

