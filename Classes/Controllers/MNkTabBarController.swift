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
    
    ///Check tab bar currently hide or not
    public var isTabBarHide:Bool{
        return  _isTabBarHide
    }
    
    private var _isTabBarHide:Bool = false
    
    ///User can scroll between tabs just swiping.
    public var isScrollableTabs:Bool = true{
        didSet{
            
            let delegate = isScrollableTabs ? tabPageController : nil
            let dataSource = isScrollableTabs ? tabPageController : nil
            
            tabPageController.delegate = delegate
            tabPageController.dataSource = dataSource
        }
    }
    
    ///Animate changing tabs when user tapped tab bar menu item
    public var isSwitchBetweenTabsAnimatable:Bool = true
    
    
    ///Frame of tab bar
    public var tabbarHeight:CGFloat{
        return statusBarHeight == 20 ? 55 : 80
    }
    
    ///Frame of tab view controllers container
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
    
    private var statusBarHeight:CGFloat{
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    public var selectedVCIndex:Int = 0{
        willSet{
            guard selectedVCIndex != newValue else{return}
            removeAllChilds()
        }
    }
    
    
    ///Set view controllers to show in tabs
    public var mnkTabBarViewControllers:[UIViewController] = []
    
    private lazy var container:TabPageContainer = {
        let con = TabPageContainer(frame: containerFrame)
        return con
    }()
    
    ///Tab bar view
    public lazy var tabBar:MNkTabBar = {
        let con = MNkTabBar(frame: tabBarFrame)
        return con
    }()
    
    private lazy var tabPageController:MenuTabsViewController = {
        let tvc = MenuTabsViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        tvc.tabPageViewControllers = self.mnkTabBarViewControllers
        tvc.tabControllerDelegate = self
        return tvc
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
        
        addControllerComp(tabPageController, to: container)
        
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
        
        let navigationDirection:UIPageViewControllerNavigationDirection = tabPageController.beforeSelectedIndex > index ? UIPageViewControllerNavigationDirection.reverse : .forward
        tabPageController.setViewControllers([tabPageController.tabPageViewControllers[index]], direction: navigationDirection, animated: isSwitchBetweenTabsAnimatable, completion: nil)
        tabPageController.beforeSelectedIndex = index
        
        tabBar.setActivateTabButton(at: index)
        
    }
    
    
    ///Set tab bar show or hide.
    public func setTabBar(hide isHide:Bool,animated isAnimated:Bool){
        
        guard _isTabBarHide != isHide else {return}
        
        _isTabBarHide = isHide
        
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

extension MNkTabBarController:MenuTabsViewControllerDelegate{
    func userScroll(to viewController: UIViewController, at index: Int) {
        tabBar.setActivateTabButton(at: index)
    }
}
