//
//  MNkTabBarButton.swift
//  lottie-ios
//
//  Created by Malith Nadeeshan on 8/4/18.
//

import UIKit
import Lottie

let tabBarButtonHeight:CGFloat = 25

protocol MNkButtonDelegate{
    func userDidChagedTap(buttonAt index:Int)
}

public class MNkTabBarButton: UIView {
    
    var delegate:MNkButtonDelegate?
    
    var type:Types = .image
    
    var isActive:Bool = false{
        willSet{
            guard isActive != newValue else {return}
            setActiveState(newValue)
        }
    }
    
    var titleResource:Any!{
        didSet{
            setResource()
        }
    }
    
    var title:String = "Title"{
        didSet{
            pageTitleLabel.text = title.capitalized
        }
    }
    
    var activeTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    var deActiveTintColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    
    var isTapped:Bool = false
    
    private let container:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageView:UIImageView?
    private var animationView:LOTAnimationView?
    
    private lazy var pageTitleLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = self.title
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = self.deActiveTintColor
        lbl.adjustsFontSizeToFitWidth = true
        lbl.isUserInteractionEnabled = true
        lbl.textAlignment = .center
        lbl.baselineAdjustment = .alignCenters
        lbl.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return lbl
    }()
    
    var isAnimate:Bool = true
    
    private lazy var tapGesture:UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = 0
        gesture.addTarget(self, action: #selector(userDidTap(_:)))
        return gesture
    }()
    
    private let stackView:UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 2
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isUserInteractionEnabled = true
        return sv
    }()
    
    private func insertAndLayoutViews(){
        addSubview(container)
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(pageTitleLabel)
        
        
        NSLayoutConstraint.activate([container.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                        constant: 4),
                                     container.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                         constant: -4),
                                     container.topAnchor.constraint(equalTo: topAnchor,
                                                                    constant: 8),
                                     container.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                       constant: -4)])
        
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                                     stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                                     stackView.topAnchor.constraint(equalTo: container.topAnchor),
                                     stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)])
        
    }
    
    
    public enum MNkButtonControllEvent{
        case up
        case down
    }
    
    public enum MNkControlState{
        case activate
        case deActivate
        case normal
    }
    public enum Types{
        case image
        case animated
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doInitWork()
    }
    
    public init(_ type:Types){
        super.init(frame: .zero)
        self.type = type
        doInitWork()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitWork()
    }
    
    private func doInitWork(){
        insertAndLayoutViews()
        addGestureRecognizer(tapGesture)
        backgroundColor = .clear
        isUserInteractionEnabled = true
    }
    
    private func setResource(){
        switch type {
        case .animated:
            guard let animationName = titleResource as? String else{return}
            animationView = LOTAnimationView(name: animationName)
            animationView?.contentMode = .scaleAspectFit
            animationView?.loopAnimation = false
            
            animationView?.translatesAutoresizingMaskIntoConstraints = false
            animationView?.heightAnchor.constraint(equalToConstant: tabBarButtonHeight).isActive = true
            animationView?.widthAnchor.constraint(equalToConstant: tabBarButtonHeight).isActive = true
            
            stackView.insertArrangedSubview(animationView!, at: 0)
            
        case .image:
            guard let image = titleResource as? UIImage else{break}
            imageView = UIImageView()
            imageView?.clipsToBounds = true
            imageView?.contentMode = .scaleAspectFit
            imageView?.isUserInteractionEnabled = true
            imageView?.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            imageView?.tintColor = tintColor
            imageView?.image = image.withRenderingMode(.alwaysTemplate)
            
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            imageView?.heightAnchor.constraint(equalToConstant: tabBarButtonHeight).isActive = true
            imageView?.widthAnchor.constraint(equalToConstant: tabBarButtonHeight).isActive = true
            
            stackView.insertArrangedSubview(imageView!, at: 0)
            
        }
    }
    
    @objc private func userDidTap(_ gesture:UILongPressGestureRecognizer){
        
        switch gesture.state {
        case .began:
            //Animation work
            guard  isAnimate else {break}
            animateClick(.down)
        case .ended:
            delegate?.userDidChagedTap(buttonAt: self.tag)
            //Animation work
            guard  isAnimate else {break}
            animateClick(.up)
        default:break
        }
        
    }
    
    private func animateClick(_ state:MNkButtonControllEvent){
        
        let transform:CGAffineTransform = state == .down ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.container.transform = transform
        }, completion: nil)
        
    }
    
    private func setActiveState(_ isActive:Bool){
        
        let buttonTint = isActive ? activeTintColor : deActiveTintColor
        pageTitleLabel.textColor = buttonTint
        
        switch type {
        case .image:
            imageView?.tintColor = buttonTint
        case .animated:
            
            guard let _animationView = animationView else{break}
            
            guard isActive else{
                if _animationView.isAnimationPlaying{_animationView.stop()}
                _animationView.animationProgress = 0
                break
            }
            
            guard !_animationView.isAnimationPlaying else{break}
            _animationView.play()
        }
        
    }
    
    ///Reload appearance of button after set new color eg.
    func reloadButtonAppearance(){
        setActiveState(self.isActive)
    }
    
}
