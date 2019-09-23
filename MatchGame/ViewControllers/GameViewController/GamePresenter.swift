//
//  GamePresenter.swift
//  MatchGame
//
//  Created by Hadevs on 22/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GamePresenter: NSObject {
  weak var view: GameViewController?
  private let gameInteractor = GameInteractor()
  private lazy var dataSource = GameDataSource(data: cards)
  
  internal let numberOfColumns = 4
  private var cards: [Card] {
    return gameInteractor.getCards()
  }
  
  internal var contentInsets: UIEdgeInsets {
    return view?.contentInsets ?? .zero
  }
  
  func viewDidLoad() {
    dataSource.delegate = self
    gameInteractor.matched = matched
    gameInteractor.flipCards = view?.flipCards
    gameInteractor.gameEnded = view?.gameEnded
    gameInteractor.playAgain = view?.playAgain
    view?.congifureTextLabels(with: gameInteractor.score, flipsLeft: gameInteractor.flipsLeft, scoreToWin: gameInteractor.scoreToWin)
    loadData()
  }
  
  func setDelegateAndDataSource(for collectionView: UICollectionView) {
    collectionView.delegate = dataSource
    collectionView.dataSource = dataSource
  }
  
  private func loadData() {
    let dataFetcher = DataFetcher()
    
    dataFetcher.getProducts(page: "1")
    { [weak self] result in
      switch result {
      case .success(let products):
        self?.gameInteractor.start(with: products)
        self?.dataSource.update(data: self?.cards ?? [])
        self?.view?.reloadData()
      case .failure: break
      }
    }
  }
    
    func playAgain() {
        gameInteractor.restart()
        view?.congifureTextLabels(with: gameInteractor.score, flipsLeft: gameInteractor.flipsLeft, scoreToWin: gameInteractor.scoreToWin)
        dataSource.update(data: cards)
        view?.reloadData()
    }
  
  private func matched(indexes: [Int]) {
      view?.matched(indexes, score: gameInteractor.score, scoreToWin: gameInteractor.scoreToWin)
  }
}


extension GamePresenter: GameDataSourceDelegate {
  func didSelect(card: Card) {
    gameInteractor.flip(card)
    view?.updateFlipLabel(with: gameInteractor.flipsLeft)
  }
}
