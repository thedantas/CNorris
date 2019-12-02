//
//  LoadingView.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoadingView: UIView, StateSubview {
    
    //MARK: Variable
    private var didSetupViews: Bool = false
    var lottieView: LOTAnimationView?
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Loading..."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: Function
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "loading_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        lottieView?.play()
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
        lottieView?.stop()
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        self.lottieView = LOTAnimationView(name: "searching")
        self.addSubview(lottieView!)
        self.addSubview(label)
        
        lottieView?.alpha = 0.8
        lottieView?.constraintWidth(120.0)
        lottieView?.constraintHeight(120.0)
        lottieView?.prepareForConstraints()
        lottieView?.centerHorizontally()
        lottieView?.centerVertically()
        lottieView?.loopAnimation = true
        
        label.prepareForConstraints()
        label.centerHorizontally()
        label.pinBottom(130)
    }
    
}
