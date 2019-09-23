//
//  DataFetcher.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-14.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation
import UIKit

struct DataFetcher {
    
    private let network: Networking
    
    init(_ network: Networking = NetworkService()) {
        self.network = network
    }
    
    func getProducts(page: String, _ completion: @escaping (Result<[CardItemable], NetworkError>) -> Void) {
        network.request(path: .products(page: page)) { result in
            switch result {
                case .success(let data):
                    guard let decoded = self.decodeJSON(type: ProductsWrapper.self, from: data) else {
                        completion(.failure(.decodeError))
                        return
                    }
                    completion(.success(decoded.products))
                
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
