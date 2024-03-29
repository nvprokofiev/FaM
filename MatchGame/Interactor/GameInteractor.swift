//
//  GameInteractor.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 16/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

class GameInteractor {
    
    private var gameItems: [CardItemable] = []
    private var cards: [Card] = []
    private(set) var score: Int = 0
    
    private var lastSelectedCards: [Card] = [] {
        didSet {
            lastSelectedCards.reserveCapacity(configuration.difficulty.level)
        }
    }
    
    var matched: (([Int]) -> Void)?
    var flipCards: (([Int]) -> Void)?
    var gameEnded: ((GameResult) -> Void)?
    var playAgain: (() -> Void)?
    
    var scoreToWin: Int {
        return configuration.scoreToWin
    }
    
    private var configuration: GameSessionConfiguration
    lazy var flipsLeft: Int = configuration.maximumFlips
    private var flipsUsed: Int = 0
    
    
    init() {
        self.configuration = UserDefaultsManager.get(GameSessionConfiguration.self) ?? GameSessionConfiguration()
    }
    
    func getCards()-> [Card]{
        return cards
    }
    
    func start(with items: [CardItemable]) {
        gameItems = items
        getCardSet()
    }
    
    private func getCardSet() {
        CardIdentifierFactory.reset()
        let cardSet = Array(gameItems.shuffled().prefix(configuration.scoreToWin))
        var sessionItems: [CardItemable] = []
        for _ in 1 ... configuration.difficulty.level {
            sessionItems += cardSet
        }
        cards = sessionItems
            .shuffled()
            .map({ Card($0) })
    }
    
    func restart() {
        configuration = UserDefaultsManager.get(GameSessionConfiguration.self) ?? GameSessionConfiguration()
        score = 0
        flipsLeft = configuration.maximumFlips
        lastSelectedCards = []
        getCardSet()
    }
    
    func flip(_ card: Card) {
        flipsUsed += 1
        flipsLeft -= 1
        card.isFaceUp.toggle()

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.flipCards?(self.pairInndexes(for: [card]))
        }
        
        if !lastSelectedCards.isEmpty {
            
            if !lastSelectedCards.contains(where: { $0 == card}) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                    
                    guard let `self` = self else { return }
                    self.lastSelectedCards.append(card)
                    self.lastSelectedCards.forEach{ $0.isFaceUp.toggle() }
                    self.flipCards?(self.pairInndexes(for: self.lastSelectedCards))
                    self.lastSelectedCards = []
                })
            } else {
                
                self.lastSelectedCards.append(card)

                if lastSelectedCards.capacity == lastSelectedCards.count {
                    score += 1
                    lastSelectedCards.forEach { $0.isMatched = true }
                    flipsLeft += configuration.flipBump
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                        guard let `self` = self else { return }
                        self.matched?(self.pairInndexes(for: self.lastSelectedCards))
                        self.lastSelectedCards = []
                    })
                }
            }
        } else {
            lastSelectedCards.append(card)
        }
        checkScore()
    }
    
    private func pairInndexes(for cards: [Card])-> [Int] {
        let indexes = cards.map { $0.id }
        return indexes
    }
    
    private func checkScore() {
        
        if score >= configuration.scoreToWin {
            callGameEnded()
            return
        }
        
        if flipsLeft <= 0 {
            callGameEnded()
        }
    }
    
    private func callGameEnded(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let `self` = self else { return }
            let result = GameResult(score: self.score, flipsUsed: self.flipsUsed, isWon: self.score == self.scoreToWin)
            self.gameEnded?(result)
        })
    }
}

