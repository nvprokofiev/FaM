//
//  NetworkService.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-13.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: APIClient, _ completion: @escaping (Result<Data, NetworkError>)-> Void)
}

final class NetworkService: Networking {

    func request(path: APIClient, _ completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = path.url else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTaks(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTaks(from request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(data))
            }
        }
    }
}
