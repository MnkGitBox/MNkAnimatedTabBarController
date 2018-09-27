//
//  MenuTabsViewController.swift
//  lottie-ios
//
//  Created by MNk_Dev on 27/9/18.
//

import UIKit

protocol MenuTabsViewControllerDelegate{
    func userScroll(to viewController:UIViewController,at index:Int)
}

class MenuTabsViewController: UIPageViewController {
    
    var tabPageViewControllers:[UIViewController] = []
    var beforeSelectedIndex:Int = 0
    
    
    var tabControllerDelegate:MenuTabsViewControllerDelegate?
    
    init(_ frame:CGRect,transitionStyle style: UIPageViewControllerTransitionStyle,navigationOrientation: UIPageViewControllerNavigationOrientation) {
        super.init(transitionStyle:style, navigationOrientation: navigationOrientation, options: [:])
        self.view.frame = frame
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let initialVc = tabPageViewControllers.first else{return}
        setViewControllers([initialVc], direction: .forward, animated: false, completion: nil)
        tabControllerDelegate?.userScroll(to: initialVc, at: 0)
    }
    
    
}


extension MenuTabsViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = tabPageViewControllers.index(of: viewController) else{return nil}
        
        beforeSelectedIndex = index
        
        tabControllerDelegate?.userScroll(to: viewController, at: index)
        
        switch index {
        case 0:
            return nil
        default:
            return tabPageViewControllers[index-1]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = tabPageViewControllers.index(of: viewController) else{return nil}
        
        beforeSelectedIndex = index
        
        tabControllerDelegate?.userScroll(to: viewController, at: index)
        
        switch index {
        case tabPageViewControllers.count - 1:
            return nil
        default:
            return tabPageViewControllers[index+1]
        }
    }
    
    
    
}
