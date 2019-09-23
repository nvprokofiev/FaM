//
//  GameDataSource.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 22/09/2019.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit
protocol GameDataSourceDelegate: class {
  func didSelect(card: Card)
  var contentInsets: UIEdgeInsets { get }
  var numberOfColumns: Int { get }
}

class GameDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  typealias DataModel = [Card]
  private var cards: DataModel
  
  private var contentInsets: UIEdgeInsets {
    return delegate?.contentInsets ?? .zero
  }
  private var numberOfColumns: Int { return delegate?.numberOfColumns ?? 0}
  
  init(data: DataModel) {
    self.cards = data
  }
  
  func update(data: DataModel) {
    self.cards = data
  }
  
  weak var delegate: GameDataSourceDelegate?
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as! CardCollectionViewCell
    let card = cards[indexPath.row]
    cell.configure(by: card)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(card: cards[indexPath.item])
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let mainWidth = collectionView.frame.width
    let spacing = (contentInsets.left + contentInsets.right) / 2
    let totalSpacing = spacing * (CGFloat(numberOfColumns - 1))
    let sizeConstant = (mainWidth - contentInsets.left - contentInsets.right - totalSpacing) / CGFloat(numberOfColumns)
    return CGSize(width: sizeConstant, height: sizeConstant)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let spacing = (contentInsets.bottom + contentInsets.top) / 2
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    let spacing = (contentInsets.left + contentInsets.right) / 2
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return contentInsets
  }
}
