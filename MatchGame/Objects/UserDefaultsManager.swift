//
//  UserDefaultsManager.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct UserDefaultsManager<T: Codable> {
    
    static func save(_ model: T){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            UserDefaults.standard.set(encoded, forKey: String(describing: T.self))
            UserDefaults.standard.synchronize()
        }
    }
    
    static func get(_ model: T.Type) -> T? {
        
        if let data = UserDefaults.standard.object(forKey: String(describing: model.self)) as? Data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(T.self, from: data) {
                return model
            }
        }
        return nil
    }
}
