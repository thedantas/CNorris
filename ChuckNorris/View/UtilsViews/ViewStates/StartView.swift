//
//  StartView.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class StartView: UIView, StateSubview {
    
    private var didSetupViews: Bool = false
    
    var lottieView: LOTAnimationView?
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "You need to wear the facts of legend Chuck Norris"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "start_view"
    }
    
    func show() {
        lottieView?.play()
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        self.lottieView = LOTAnimationView(name: "warning")
        self.addSubview(lottieView!)
        self.addSubview(label)
        
        lottieView?.alpha = 0.8
        lottieView?.constraintWidth(120.0)
        lottieView?.constraintHeight(120.0)
        lottieView?.prepareForConstraints()
        lottieView?.centerHorizontally()
        lottieView?.centerVertically()
        lottieView?.loopAnimation = true
        
        self.label.prepareForConstraints()
        self.label.pinLeft(32)
        self.label.pinRight(32)
        self.label.pinBottom(130)
    
    }
    
}
