//
//  GameViewController.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-14.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var matchesOfLabel: UILabel!
    @IBOutlet private weak var flipLabel: UILabel!
    @IBOutlet private weak var settingsButton: UIButton!
    
    private let presenter = GamePresenter()
    private lazy var router = GameRouter()
    let contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    private lazy var gameResultView: GameResultView = {
        let view = GameResultView.loadFromNib()
        view.frame = collectionView.frame
        view.playAgain = playAgain
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        presenter.setDelegateAndDataSource(for: collectionView)
        styleViews()
        
        collectionView.register(UINib.init(nibName: String(describing: CardCollectionViewCell.self), bundle: Bundle(for: CardCollectionViewCell.self)), forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
    }
    
    private func styleViews(){
        topView.layer.borderColor = UIColor.lightGray.cgColor
        topView.layer.borderWidth = 0.5
        
        settingsButton.layer.shadowColor = UIColor.black.cgColor
        settingsButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        settingsButton.layer.shadowOpacity = 0.2
        settingsButton.layer.shadowRadius = 2.0
        settingsButton.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        settingsButton.layer.cornerRadius = settingsButton.bounds.height / 2
        settingsButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func updateFlipLabel(with flipsLeft: Int) {
        flipLabel.text = "\(flipsLeft)"
    }
    
    func congifureTextLabels(with score: Int, flipsLeft: Int, scoreToWin: Int) {
        scoreLabel.text = "\(score)"
        flipLabel.text = "\(flipsLeft)"
        setMatchesOfTitle(score: score, scoreToWin: scoreToWin)
    }
    
    func gameEnded(_ result: GameResult) {
        gameResultView.result = result
        collectionView.isHidden = true
        self.view.addSubview(gameResultView)
    }
    
    func matched(_ indexes: [Int], score: Int, scoreToWin: Int) {
        scoreLabel.text = "\(score)"
        let cells = convertedIndexes(indexes).compactMap { collectionView.cellForItem(at: $0) } as? [CardCollectionViewCell]
        cells?.forEach { $0.hide() }
        setMatchesOfTitle(score: score, scoreToWin: scoreToWin)
    }
    
    func flipCards(_ indexes: [Int]) {
        let cells = convertedIndexes(indexes).compactMap { collectionView.cellForItem(at: $0) } as? [CardCollectionViewCell]
        cells?.forEach { $0.flip() }
    }
    
    func playAgain() {
        
        gameResultView.removeFromSuperview()
        collectionView.isHidden = false
        presenter.playAgain()
    }
    
    private func convertedIndexes(_ indexes: [Int]) -> [IndexPath] {
        let indexPaths = indexes.map { IndexPath(item: $0 - 1, section: 0)}
        return indexPaths
    }
    
    private func setMatchesOfTitle(score: Int, scoreToWin: Int) {
        var ending = ""
        let score = score
        if score % 10 != 1 && score != 11 {
            ending = "es"
        }
        matchesOfLabel.text = "match\(ending) of \(scoreToWin)"
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        router.route(to: .settings, from: self)
    }
}

extension GameViewController: GameConfigurationChangeable {
    
    func didChangeConfiguration() {
        playAgain()
    }
}
