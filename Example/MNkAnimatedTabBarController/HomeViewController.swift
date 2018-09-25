//
//  HomeViewController.swift
//  MNkAnimatedTabBarController_Example
//
//  Created by Malith Nadeeshan on 9/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MNkAnimatedTabBarController

class HomeViewController: UIViewController {
    
    private lazy var goWithHideTabbarButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Go And Hide Tab Bar", for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btn.addTarget(self, action: #selector(goBtnTapped), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 3
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func insertAndLayoutSubviews(){
        view.addSubview(goWithHideTabbarButton)
        NSLayoutConstraint.activate([goWithHideTabbarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     goWithHideTabbarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        insertAndLayoutSubviews()
    }
    
    @objc private func goBtnTapped(){
        navigationController?.pushViewController(HomeDetailViewController(), animated: true)
        animatedTabBarController?.setTabBar(hide: true, animated: true)
    }

}
