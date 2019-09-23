//
//  NetworkError.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-14.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case decodeError
    case invalidImageData
}
