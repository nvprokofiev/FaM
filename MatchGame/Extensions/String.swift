//
//  String.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-20.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
}
