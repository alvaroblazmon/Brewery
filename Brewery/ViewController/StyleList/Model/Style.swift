//
//  Style.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import SwiftyJSON

struct Style {
    
    enum Key: String {
        case id, name, description
    }
    
    let id: String
    let name: String
    let description: String
}

extension Style {
    init(json: JSON) {
        self.id = json[Key.id.rawValue].stringValue
        self.name = json[Key.name.rawValue].stringValue
        self.description = json[Key.description.rawValue].stringValue
    }
}
