//
//  MNkTabBarController.swift
//  lottie-ios
//
//  Created by Malith Nadeeshan on 8/4/18.
//


//        |\/\            /\/|
//        |\/\/\         /\/\|
//        |\/\/\/\    /\/\/\/|
//        |\/\/\/\/\_/\/\/\/\|
//        |\/\  /\/\_/\/  \/\|
//        |\/\   \/\_/\    /\|



import UIKit

public var animatedTabBar:MNkTabBar?
public var animatedTabBarController:MNkTabBarController?

open class MNkTabBarController: UIViewController {
    
    public var tabbarHeight:CGFloat{
        return statusBarHeight == 20 ? 55 : 80
    }
    
    public var containerFrame:CGRect{
        return CGRect(origin: .zero, size: CGSize(width: self.view.bounds.size.width,
                                                  height: self.view.bounds.size.height - tabbarHeight))
    }
    
    private var tabBarFrame:CGRect{
        let origin = CGPoint(x: 0,
                             y: containerFrame.size.height)
        return CGRect(origin: origin,
                      size: CGSize(width: self.view.bounds.size.width,
                                   height: tabbarHeight))
    }
    
    public var selectedVCIndex:Int = 0{
        willSet{
            guard selectedVCIndex != newValue else{return}
            removeAllChilds()
            setToCurrent(mnkTabBarViewControllers[newValue])
        }
    }
    
    private var isSetInitPage = false
    
    public var mnkTabBarViewControllers:[UIViewController] = []
    
    private var statusBarHeight:CGFloat{
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    private lazy var container:TabPageContainer = {
        let con = TabPageContainer(frame: containerFrame)
        return con
    }()
    
    public lazy var tabBar:MNkTabBar = {
        let con = MNkTabBar(frame: tabBarFrame)
        return con
    }()
    
    public init(){
        super.init(nibName: nil, bundle: nil)
        doInitialWork()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialWork()
    }
    
    ///Set subview controllers and add animated or still images to tab bar
    open func setSubViewControllers(){}
    
    private func doInitialWork(){
        view.backgroundColor = .white
        insertAndLayoutSubviews()
        
        setSubViewControllers()
        
        setSelectedVC(at: 0)
        
        animatedTabBar = tabBar
        animatedTabBarController = self
    }
    
    //MARK:- LAYOUT SUBVIEWS OF VIEW CONTROLLER
    private func insertAndLayoutSubviews(){
        view.addSubview(container)
        view.addSubview(tabBar)
    }
    
    //    /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\//\\/\/\/\/\/\/\\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\/\/\/\
    //MARK:- FUNCTIONS THAT MADE FOR WORK USER TO CONFIGURE TAB BAR
    
    public func insertMnkTabbar(itemAt tag:Int,titleResouse resouse:Any,for title:String,_ type:MNkTabBarButton.Types = .image){
        let button = MNkTabBarButton()
        button.tag = tag
        button.type = type
        button.titleResource = resouse
        button.title = title
        button.delegate = self
        tabBar.insertNew(tabbarButton: button)
    }
    
    
    private func setSelectedVC(at index:Int){
        
        guard mnkTabBarViewControllers.count > index else{return}
        
        if isSetInitPage{
            selectedVCIndex = index
        }else{
            setToCurrent(mnkTabBarViewControllers[index])
            isSetInitPage = true
        }
        
        
        tabBar.setActivateTabButton(at: index)
        
    }
    
    private func setToCurrent(_ vc:UIViewController){
        addControllerComp(vc, to: container)
    }
    
    private func removeCurrent(_ vc:UIViewController){
        vc.removeFromParentVC()
    }
    
    ///Set tab bar show or hide.
    public func setTabBar(hide isHide:Bool,animated isAnimated:Bool){
        
        let _tabBarAnimatedOriginY = isHide ? (tabBarFrame.origin.y + tabBarFrame.size.height) : tabBarFrame.origin.y
        let _containerFrame = isHide ? CGRect(origin: .zero, size: CGSize(width: containerFrame.size.width, height: (containerFrame.size.height + tabBarFrame.size.height) - self.view.safeAreaInsets.bottom)) : containerFrame
        
        let animateTime:Double = isAnimated ? 0.4 : 0.0
        
        UIView.animate(withDuration: animateTime, delay: 0, options: .curveEaseOut, animations: {
            self.tabBar.frame.origin.y = _tabBarAnimatedOriginY
            self.container.frame = _containerFrame
        }, completion: nil)
        
    }
    
}

extension MNkTabBarController:MNkButtonDelegate{
    func userDidChagedTap(buttonAt index: Int) {
        setSelectedVC(at: index)
    }
}

extension UIViewController{
    //MARK:- ADD MAIN VIEW CONTROLLERS AS CHILD VIEW CONTROLLERS TO MAIN VIEW CONTROLLER
    func addControllerComp(_ controller:UIViewController,to container:UIView){
        
        addChildViewController(controller)
        
        container.addSubview(controller.view)
        controller.view.frame = container.bounds
        controller.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        controller.didMove(toParentViewController: self)
    }
    
    func removeFromParentVC(){
        self.dismiss(animated: false, completion: nil)
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func removeAllChilds(){
        for child in childViewControllers{
            child.removeFromParentVC()
        }
    }
    
}


