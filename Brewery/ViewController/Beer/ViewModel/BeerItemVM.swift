//
//  BeerItemVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation

class BeerItemVM {
    
    weak var parent: FavoritesDelegate?
    var coordinator: BeerCoordinator?
    let beer: Beer
    
    var id: String {
        return beer.id
    }
    
    var name: String {
        return beer.name
    }
    
    var description: String {
        return beer.description
    }
    
    var isOrganic: String {
        if beer.isOrganic == "Y" {
            return "Yes"
        }
        return "No"
    }
    
    var abv: String {
        return beer.abv + "%"
    }
    
    var ibu: String {
        return beer.ibu
    }
    
    var icon: String {
        return beer.icon
    }
    
    var image: String {
        return beer.image
    }
    
    var isFavorite = false
    
    init (_ beer: Beer) {
        self.beer = beer
    }
    
    func changeFavorite() {
        isFavorite = !isFavorite
        parent?.changeFavorite(favorite: self)
    }
    
    func goPhotoBeer() {
        if let url = URL(string: self.image) {
            let transition = BeerTransition.goPhotoBeer(url: url)
            coordinator?.performTransition(transition: transition)
        }
    }
    
}
