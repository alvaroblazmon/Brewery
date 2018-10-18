//
//  Storage.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 17/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation

protocol FavoritesStorage {
    func save(favorite id: String)
    func delete(favorite id: String)
    func isFavorite(favorite id: String) -> Bool
}

class Storage {
    
    enum Key: String {
        case favorites
    }
    
    class Favorites: FavoritesStorage {
        
        let defaults = UserDefaults.standard
        var data: [String]
        
        init() {
            self.data = []
            if let data = defaults.array(forKey: Storage.Key.favorites.rawValue) as? [String] {
                self.data = data
            }
        }
        
        func save(favorite id: String) {
            if data.contains(id) {
                return
            }
            data.append(id)
            defaults.set(data, forKey: Storage.Key.favorites.rawValue)
        }
        
        func delete(favorite id: String) {
            guard let index = data.firstIndex(of: id) else {
                return
            }
            
            data.remove(at: index)
            defaults.set(data, forKey: Storage.Key.favorites.rawValue)
        }
        
        func isFavorite(favorite id: String) -> Bool {
            return data.contains(id)
        }
        
    }

}
