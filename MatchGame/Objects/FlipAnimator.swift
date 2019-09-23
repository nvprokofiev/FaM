//
//  FlipAnimator.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-21.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

struct FlipAnimator {
  
  enum AnimationType {
    case open
    case close
    case hide
  }
  
  private let view: UIView
  private let type: AnimationType

  init(view: UIView, type: AnimationType) {
    self.view = view
    self.type = type
  }
  
  @discardableResult
  func animate(_ completion: @escaping () -> Void) -> FlipAnimator {
    var flipTransform: CATransform3D
    flipTransform = CATransform3DIdentity
    flipTransform.m34 = 1.0 / -500
    flipTransform = CATransform3DRotate(flipTransform, .pi/2, 0.0, 1.0, 0.0)
    
    animate(firstAnimationsClosure: {
      self.view.layer.transform = flipTransform
    }, secondAnimationsCosure: {
      let secondTrasnform = self.transform(for: self.type, of: flipTransform)
      self.secondAnimationsClosure(for: secondTrasnform)
    }, completion: completion)
    return self
  }
  
  private func secondAnimationsClosure(for transform: CATransform3D?) {
    guard let flipTransform = transform else {
      return
    }
    UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
      self.view.layer.transform = flipTransform
    })
  }
  
  private func animate(firstAnimationsClosure: @escaping () -> Void,
                       secondAnimationsCosure: (() -> Void)?,
                       completion: @escaping () -> Void) {
    UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn], animations: {
      firstAnimationsClosure()
    }, completion: {_ in
      completion()
      secondAnimationsCosure?()
    })
  }
  
  private func transform(for type: AnimationType, of existingTransorm: CATransform3D) -> CATransform3D? {
    switch type {
    case .close: return CATransform3DRotate(existingTransorm, .pi/2, 0.0, 1.0, 0.0)
    case .open: return CATransform3DRotate(existingTransorm, -.pi/2, 0.0, 1.0, 0.0)
    default: return nil
    }
  }
}
