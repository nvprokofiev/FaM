//
//  GameResullt.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct GameResult {
    let score: Int
    let flipsUsed: Int
    let isWon: Bool
}

enum GameResultEnum {
    
    case gameWon(GameResult)
    case gameOver (GameResult)
    
    var title: String {
        switch self {
        case .gameWon: return "Hooray!"
        case .gameOver: return "Oh no!"
        }
    }
    
    var description: String {
        switch self {
        case .gameWon(let result):
            return "You have matched all \(result.score) cards for just \(result.flipsUsed) flips"
        case .gameOver(let result):
            return "You have used all \(result.flipsUsed) flips"
        }
    }
}
