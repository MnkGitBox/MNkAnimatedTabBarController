//
//  TabBarController.swift
//  MNkAnimatedTabBarController_Example
//
//  Created by Malith Nadeeshan on 9/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MNkAnimatedTabBarController

class TabBarController: MNkTabBarController {
    override func setSubViewControllers() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let listVC = ListViewController()
        let aboutVC = AboutViewController()
        
        insertMnkTabbar(itemAt: 0, titleResouse:#imageLiteral(resourceName: "home_ico"), for: "Home")
        insertMnkTabbar(itemAt: 1, titleResouse:#imageLiteral(resourceName: "about_ico"), for: "About")
        insertMnkTabbar(itemAt: 2, titleResouse: "ani_categories", for: "List", .animated)
        
        mnkTabBarViewControllers = [homeVC,aboutVC,listVC]
        
        tabBar.tintColorButtonClicked = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        isScrollableTabs = true
        isSwitchBetweenTabsAnimatable = true
        
    }
    
}
