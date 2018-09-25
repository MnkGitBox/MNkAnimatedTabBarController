//
//  HomeDetailViewController.swift
//  MNkAnimatedTabBarController_Example
//
//  Created by Malith Nadeeshan on 9/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MNkAnimatedTabBarController

class HomeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animatedTabBarController?.setTabBar(hide: false, animated: true)
    }
    

   
}
