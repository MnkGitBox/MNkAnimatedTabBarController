//
//  Support.swift
//  lottie-ios
//
//  Created by MNk_Dev on 27/9/18.
//

import UIKit

extension UIViewController{
    //MARK:- ADD MAIN VIEW CONTROLLERS AS CHILD VIEW CONTROLLERS TO MAIN VIEW CONTROLLER
    func addControllerComp(_ controller:UIViewController,to container:UIView){
        
        addChildViewController(controller)
        
        container.addSubview(controller.view)
        controller.view.frame = container.bounds
        controller.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        controller.didMove(toParentViewController: self)
    }
    
    public func removeFromParentVC(){
        self.dismiss(animated: false, completion: nil)
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    public func removeAllChilds(){
        for child in childViewControllers{
            child.removeFromParentVC()
        }
    }
    
}

