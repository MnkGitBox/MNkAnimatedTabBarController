//
//  MNkTabBar.swift
//  lottie-ios
//
//  Created by Malith Nadeeshan on 8/4/18.
//

import UIKit

public class MNkTabBar: UIView {
    
    public var backgroundTint:UIColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1){
        didSet{
            shadowView.backgroundColor = backgroundTint
        }
    }
    
    public var isShadowActive:Bool = true{
        didSet{
            let shadowOpacity:Float = isShadowActive ? 0.15 : 0.0
            shadowView.layer.shadowOpacity = shadowOpacity
        }
    }
    
    public var tintColorButtonClicked:UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    public var tintColorButtonUnClicked:UIColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    
    private lazy var shadowView:UIView = {
        let v = UIView()
        v.layer.shadowOpacity = 0.15
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: -1)
        v.layer.shadowRadius = 2.0
        v.frame = CGRect(x: 0, y: 0.5, width: bounds.size.width, height: bounds.size.height-0.5)
        v.clipsToBounds = false
        v.layer.masksToBounds = false
        v.backgroundColor = backgroundTint
        return v
    }()
    
    private lazy var buttonStackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 1
        sv.clipsToBounds = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .clear
        return sv
    }()
    
    
    public init() {
        super.init(frame: .zero)
        doinitWork()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doinitWork()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doinitWork()
    }
    
    private func doinitWork(){
        backgroundColor = backgroundTint
        clipsToBounds = true
        inserAndLayoutViews()
    }
    
    private func inserAndLayoutViews(){
        addSubview(shadowView)
        addSubview(buttonStackView)
        NSLayoutConstraint.activate([buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     buttonStackView.topAnchor.constraint(equalTo: topAnchor,
                                                                          constant:0.5),
                                     buttonStackView.heightAnchor.constraint(equalToConstant: 54.5)])
    }
    
    ///
    func insertNew(tabbarButton button:MNkTabBarButton){
        buttonStackView.addArrangedSubview(button)
    }
    
    func setActivateTabButton(at index:Int){
        for button in buttonStackView.arrangedSubviews{
            guard let _button = button as? MNkTabBarButton else{continue}
            let activate = _button.tag == index ? true : false
            _button.setTintColor(tintColorButtonClicked, for: .activate)
            _button.setTintColor(tintColorButtonUnClicked, for: .deActivate)
            _button.isActive = activate
        }
    }
    
    
    
}
