//
//  Beer.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import SwiftyJSON

struct Beer {
    enum Key: String {
        case id, name, description, isOrganic, abv, ibu
        case icon, image = "large", labels
    }
    
    let id: String
    let name: String
    let description: String
    let isOrganic: String
    let abv: String
    let ibu: String
    let icon: String
    let image: String
}

extension Beer {
    
    init(json: JSON) {
        self.id = json[Key.id.rawValue].stringValue
        self.name = json[Key.name.rawValue].stringValue
        self.description = json[Key.description.rawValue].stringValue
        self.isOrganic = json[Key.isOrganic.rawValue].stringValue
        self.abv = json[Key.abv.rawValue].stringValue
        self.ibu = json[Key.ibu.rawValue].stringValue
        let labels = json[Key.labels.rawValue]
        self.icon = labels[Key.icon.rawValue].stringValue
        self.image = labels[Key.image.rawValue].stringValue
    }
    
}
