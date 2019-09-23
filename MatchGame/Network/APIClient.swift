//
//  API.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-13.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum APIClient {
    case products(page: String)
}

extension APIClient {
    typealias Params = [String: String]
    
    private var scheme: String { return "https" }
    private var host: String { return "shopicruit.myshopify.com" }
    private var token: String { return "c32313df0d0ef512ca64d5b336a0d7c6" }
    
    private var path: String {
        switch self {
        case .products:
            return "/admin/products.json"
        }
    }
    
    private var params: Params {
        switch self {
        case .products(let page):
            return ["page": page]
        }
    }
    
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = self.path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        components.queryItems?.append( URLQueryItem(name: "access_token", value: token))
        
        return components
    }
    
    var url: URL? {
        return components.url
    }
}
