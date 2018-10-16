//
//  StyleItemVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

class StyleItemVM {
    
    let style: Style
    
    var id: String {
        return style.id
    }
    var name: String {
        return style.name
    }
    var description: String {
        return style.description
    }
    
    init(_ style: Style) {
        self.style = style
    }
    
}
