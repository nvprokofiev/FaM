//
//  StyleHelper.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-21.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

typealias TwoColorsGradient = (from: UIColor, to: UIColor)

protocol StyleHelper {}

extension StyleHelper where Self: UIView {
  
  func setGradientBackgroundColor(to view: UIView, colors: TwoColorsGradient = Gradients().random()) {
    layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [colors.from.cgColor, colors.to.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.cornerRadius = 6.0
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setCornerRadius(to view: UIView){
    view.layer.cornerRadius = 6.0
    view.layer.masksToBounds = true
    view.layer.borderWidth = 0.5
    view.layer.borderColor = UIColor.clear.cgColor
  }
  
  func setShadow(to view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 1)
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 1.0
    view.layer.masksToBounds = false
    view.layer.cornerRadius = 6.0
    view.clipsToBounds = false
  }
  
}


