//
//  MNkTabBar.swift
//  lottie-ios
//
//  Created by Malith Nadeeshan on 8/4/18.
//

import UIKit

public class MNkTabBar: UIView {
    
    public var backgroundTint:UIColor = .clear{
        didSet{
            backgroundColor = backgroundTint
        }
    }
    
    public var activetedTintColor:UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    public var deActivatedTintColor:UIColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    
    private lazy var buttonStackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 1
        sv.clipsToBounds = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    public init() {
        super.init(frame: .zero)
        doinitWork()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doinitWork()
    }
    
    private func doinitWork(){
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        clipsToBounds = true
        inserAndLayoutViews()
    }
    
    private func inserAndLayoutViews(){
        addSubview(buttonStackView)
        NSLayoutConstraint.activate([buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     buttonStackView.topAnchor.constraint(equalTo: topAnchor),
                                     buttonStackView.heightAnchor.constraint(equalToConstant: 60)])
    }
    
    func insertNew(tabbarButton button:MNkTabBarButton){
        buttonStackView.addArrangedSubview(button)
    }
    
    func setActivateTabButton(at index:Int){
        for button in buttonStackView.arrangedSubviews{
            guard let _button = button as? MNkTabBarButton else{continue}
            let activate = _button.tag == index ? true : false
            _button.setTintColor(activetedTintColor, for: .activate)
            _button.setTintColor(deActivatedTintColor, for: .deActivate)
            _button.isActive = activate
        }
    }
    
}
