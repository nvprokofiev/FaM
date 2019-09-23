//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 16/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell, StyleHelper {
  
  @IBOutlet private weak var cardImageView: UIImageView!
    var card: Card?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(by card: Card) {
        self.card = card
        cardImageView.kf.setImage(with: card.item.imageURL)
        self.cardImageView.isHidden = true
        setupStyle()
        if card.isMatched {
            isHidden = true
            isUserInteractionEnabled = false
        } else {
            isHidden = false
            cardImageView.isHidden = card.isFaceUp
            isUserInteractionEnabled = card.isFaceUp
        }
    }
    
    func flip(){
        guard let isFaceUp = card?.isFaceUp else { return }
        isFaceUp ? closeCard() : openCard()
    }
    
    func openCard() {
        isUserInteractionEnabled = false
      FlipAnimator(view: self, type: .open).animate {
        self.cardImageView.isHidden = false
      }
    }
    
    func closeCard() {
        self.isUserInteractionEnabled = true
      FlipAnimator(view: self, type: .close).animate {
        self.cardImageView.isHidden = true
      }
    }
    
    func hide() {
        isUserInteractionEnabled = false
      FlipAnimator(view: self, type: .hide).animate {
        self.isHidden = true
      }
    }

    
    private func setupStyle() {
        guard let card = card else { return }
        setGradientBackgroundColor(to: self, colors: card.faceColor)
        setCornerRadius(to: self)
        setShadow(to: self)
    }
}
