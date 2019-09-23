//
//  GameRouter.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 22/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit
import SPStorkController

class GameRouter {
    enum Screen {
        case settings
    }
    
    func route(to screen: Screen, from sourceViewController: UIViewController) {
        switch screen {
        case .settings:
            let vc = SettingsViewController()
            let transitionDelegate = SPStorkTransitioningDelegate()
            transitionDelegate.showCloseButton = true
            transitionDelegate.storkDelegate = vc
            vc.transitioningDelegate = transitionDelegate
            vc.modalPresentationStyle = .custom
            vc.modalPresentationCapturesStatusBarAppearance = true
            vc.delegate = sourceViewController as! GameConfigurationChangeable
            sourceViewController.present(vc, animated: true, completion: nil)
        }
        
    }
}
