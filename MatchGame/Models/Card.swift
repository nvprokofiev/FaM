//
//  Card.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-18.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

protocol CardItemable {
    var id: Int { get }
    var imageURL: URL? { get }
}

class Card: Equatable {
    
    var item: CardItemable
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    private(set) var faceColor: TwoColorsGradient
    
    private(set) var id: Int
    
    init(_ item: CardItemable) {
        self.item = item
        self.id = CardIdentifierFactory.getUniqueId()
        self.faceColor = Gradients().random()
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.item.id == rhs.item.id
    }
}

struct CardIdentifierFactory {
    private static var idFactory = 0
    static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    static func reset(){
        idFactory = 0
    }
}
