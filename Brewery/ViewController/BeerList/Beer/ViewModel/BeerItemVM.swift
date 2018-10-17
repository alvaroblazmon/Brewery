//
//  BeerItemVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

class BeerItemVM {
    
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
        if (beer.isOrganic == "Y") {
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
    
}
