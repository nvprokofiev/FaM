//
//  GameResultView.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-20.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GameResultView: UIView, NibLoadable, StyleHelper {

    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var resultDescriptionLabel: UILabel!
    @IBOutlet private weak var playAgainButton: UIButton!

    var result: GameResult?
    var playAgain: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupViews()
    }
    
    private func setupViews() {
        guard let result = result else { return }
        let gameResult = result.isWon ? GameResultEnum.gameWon(result) :  GameResultEnum.gameOver(result)
        
        resultLabel.text = gameResult.title
        resultDescriptionLabel.text = gameResult.description
        setCornerRadius(to: playAgainButton)
        setShadow(to: playAgainButton)
    }
    
    @IBAction func playAgainTapped(_ sender: Any) {
        playAgain?()
    }
}
