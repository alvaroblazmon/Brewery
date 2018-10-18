//
//  StyleItemVM.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
@testable import Brewery

class StyleItemVMTest: XCTestCase {

    var style: Style!
    override func setUp() {
        style = Style(id: "1", name: "Beer", description: "descripcion")
    }

    func testNewStyle() {
        let styleItemVM = StyleItemVM(style)
        
        XCTAssertEqual(styleItemVM.id, "1")
        XCTAssertEqual(styleItemVM.name, "Beer")
        XCTAssertEqual(styleItemVM.description, "descripcion")
    }
    
    func testGetFormData() {
        let styleItemVM = StyleItemVM(style)
        let formData = styleItemVM.getFormData()
        XCTAssertEqual(formData["styleId"], "1")
    }

}
