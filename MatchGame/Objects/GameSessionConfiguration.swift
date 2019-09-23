//
//  GameSessionConfiguration.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 16/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct GameSessionConfiguration {
    private(set) var scoreToWin: Int = 2
    private(set) var difficulty: Difficulty = .easy
    
    var flipBump: Int {
        switch difficulty {
        case .easy: return 2
        case .medium: return 3
        case .hard: return 4
        }
    }
    
    var maximumFlips: Int {
        return scoreToWin * 2
    }
    
    mutating func setScoreToWin(to value: Int) {
        scoreToWin = value
    }
    
    mutating func setDifficulty(to value: Difficulty) {
        difficulty = value
    }
}

extension GameSessionConfiguration: Codable {
    
    enum CodingKeys: String, CodingKey {
        case scoreToWin
        case flipBump
        case difficulty
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scoreToWin, forKey: .scoreToWin)
        try container.encode(difficulty.rawValue, forKey: .difficulty)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scoreToWin = try values.decode(Int.self, forKey: .scoreToWin)
        let rawValue  = try values.decode(Int.self, forKey: .difficulty)
        difficulty = Difficulty(rawValue: rawValue) ?? .easy
    }
    
}
