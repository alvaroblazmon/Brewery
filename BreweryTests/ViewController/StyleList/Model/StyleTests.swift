//
//  BreweryTests.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Brewery

class StyleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testJSON() {
        let string = "{\"id\": \"1\",\"name\": \"Beer\",\"description\": \"descripcion\"}"
        let json = JSON(parseJSON: string)
        let style = Style(json: json)
        
        XCTAssertEqual(style.id, "1")
        XCTAssertEqual(style.name, "Beer")
        XCTAssertEqual(style.description, "descripcion")
        
    }
    
    func testBadJSON() {
        let string = "{\"idddd\": \"1\",\"nameeee\": \"Beer\",\"descriptiooon\": \"descripcion\"}"
        let json = JSON(parseJSON: string)
        let style = Style(json: json)
        
        XCTAssertEqual(style.id, "")
        XCTAssertEqual(style.name, "")
        XCTAssertEqual(style.description, "")
    }

}
