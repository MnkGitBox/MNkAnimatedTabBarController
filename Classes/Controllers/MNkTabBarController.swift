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

open class MNkTabBarController: UIViewController {
    
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
        let con = TabPageContainer()
        con.translatesAutoresizingMaskIntoConstraints = false
        return con
    }()
    
    public lazy var tabBar:MNkTabBar = {
        let con = MNkTabBar()
        con.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func doInitialWork(){
        
        insertAndLayoutSubviews()
        setSelectedVC(at: 0)
    }
    
    //MARK:- LAYOUT SUBVIEWS OF VIEW CONTROLLER
    private func insertAndLayoutSubviews(){
        
        view.addSubview(container)
        view.addSubview(tabBar)
        
        let tabbarHeight:CGFloat = statusBarHeight == 20 ? 60.0 : 80
        
        NSLayoutConstraint.activate([tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tabBar.heightAnchor.constraint(equalToConstant: tabbarHeight)])
        
        NSLayoutConstraint.activate([container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     container.topAnchor.constraint(equalTo: view.topAnchor),
                                     container.bottomAnchor.constraint(equalTo: tabBar.topAnchor)])
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
    
}

extension MNkTabBarController:MNkButtonDelegate{
    func userDidChagedTap(buttonAt index: Int) {
        setSelectedVC(at: index)
    }
}

extension UIViewController{
    //MARK:- ADD MAIN VIEW CONTROLLERS AS CHILD VIEW CONTROLLERS TO MAIN VIEW CONTROLLER
    func addControllerComp(_ controller:UIViewController,to container:UIView){
        container.addSubview(controller.view)
        controller.view.frame = container.bounds
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
    
    func removeFromParentVC(){
        if self.isBeingPresented{
            self.dismiss(animated: false, completion: nil)
        }
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        self.willMove(toParentViewController: nil)
    }
    
    func removeAllChilds(){
        for child in childViewControllers{
            child.removeFromParentVC()
        }
    }
}



