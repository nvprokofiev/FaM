//
//  Nibloadable.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-20.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

// MARK: - protocol NibLoadable

protocol NibLoadable: class {
    static var nib: UINib { get }
}

// MARK: - extension NibLoadable

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    
    static var name: String {
        return String(describing: self)
    }
}

// MARK: - extension NibLoadable where Self: UIView

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        
        return view
    }
}
