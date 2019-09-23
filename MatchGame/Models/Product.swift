//
//  Product.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-13.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct ProductsWrapper: Decodable {
  let products: [Product]
}

struct Product: CardItemable, Decodable {
    let id: Int
    let title: String
    private let image: ProductImage
    
    var imageURL: URL? {
        return image.url
    }
}

struct ProductImage: Decodable {
  private let src: String
  
  var url: URL? {
    return URL(string: src)
  }
}
