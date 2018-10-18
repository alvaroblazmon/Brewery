//
//  Beer.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Brewery

class BeerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testJSON() {
        
        let string = "{\"id\": \"1\",\"name\": \"Beer\",\"description\": \"descripcion\",\"isOrganic\": \"Y\"," +
                    "\"abv\": \"10\",\"ibu\": \"2\", \"labels\": {\"medium\": \"icon\",\"large\": \"image\"}}"
        
        let json = JSON(parseJSON: string)
        let beer = Beer(json: json)
        
        XCTAssertEqual(beer.id, "1")
        XCTAssertEqual(beer.name, "Beer")
        XCTAssertEqual(beer.description, "descripcion")
        XCTAssertEqual(beer.isOrganic, "Y")
        XCTAssertEqual(beer.abv, "10")
        XCTAssertEqual(beer.ibu, "2")
        XCTAssertEqual(beer.icon, "icon")
        XCTAssertEqual(beer.image, "image")
        
    }
    
    func testBadJSON() {
        let string = "{\"idd\": \"1\",\"namee\": \"Beer\",\"descriptionn\": \"descripcion\",\"isOrganicc\": \"Y\" ," +
                    "\"abvv\": \"10\",\"ibuu\": \"2\",\"mediumm\": \"icon\",\"largee\": \"image\"}"
        let json = JSON(parseJSON: string)
        let beer = Beer(json: json)
        
        XCTAssertEqual(beer.id, "")
        XCTAssertEqual(beer.name, "")
        XCTAssertEqual(beer.description, "")
        XCTAssertEqual(beer.isOrganic, "")
        XCTAssertEqual(beer.abv, "")
        XCTAssertEqual(beer.ibu, "")
        XCTAssertEqual(beer.icon, "")
        XCTAssertEqual(beer.image, "")
    }

}
