//
//  Difficulty.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum Difficulty: Int {
    case easy = 0
    case medium = 1
    case hard = 2
    
    var level: Int {
        switch self {
            case .easy: return 2
            case .medium: return 3
            case .hard: return 4
        }
    }
    
    var description: String {
        switch self {
            case .easy: return "Match just two cards and you win"
            case .medium: return "Not easy, not hard. Match three cards and get cool \"match\""
            case .hard: return "Four cards to match. Do you realy want this???"
        }
    }
}
