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
    
    class Favorites: FavoritesStorage {
        
        enum Key: String {
            case favorites
        }
        
        let defaults = UserDefaults.standard
        var data: [String]
        
        init() {
            self.data = []
            if let data = defaults.array(forKey: Key.favorites.rawValue) as? [String] {
                self.data = data
            }
        }
        
        func save(favorite id: String) {
            if data.contains(id) {
                return
            }
            print("llega " + id)
            data.append(id)
            defaults.set(data, forKey: Key.favorites.rawValue)
            print("guardado " + id)
        }
        
        func delete(favorite id: String) {
            guard let index = data.firstIndex(of: id) else {
                return
            }
            
            data.remove(at: index)
            defaults.set(data, forKey: Key.favorites.rawValue)
        }
        
        func isFavorite(favorite id: String) -> Bool {
            return data.contains(id)
        }
        
    }

}
