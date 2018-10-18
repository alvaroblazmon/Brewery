//
//  BeerItemVM.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
@testable import Brewery

class BeerItemVMTests: XCTestCase {

    var beer: Beer!
    let mockFavorite = MockFavoritesDelegate()
    let mockCoordinator = MockCoordinator()
    
    override func setUp() {
        beer = Beer(id: "1", name: "Beer", description: "des", isOrganic: "Y", abv: "10", ibu: "2", icon: "icon", image: "http://pruebaimage.es")
    }

    func testNewBeerItemVM() {
        let beerItemVM = BeerItemVM(beer)
        
        XCTAssertEqual(beerItemVM.id, "1")
        XCTAssertEqual(beerItemVM.name, "Beer")
        XCTAssertEqual(beerItemVM.description, "des")
        XCTAssertEqual(beerItemVM.isOrganic, "Yes")
        XCTAssertEqual(beerItemVM.abv, "10%")
        XCTAssertEqual(beerItemVM.ibu, "2")
        XCTAssertEqual(beerItemVM.icon, "icon")
        XCTAssertEqual(beerItemVM.image, "http://pruebaimage.es")
        XCTAssertFalse(beerItemVM.isFavorite)
    }
    
    func testChangeFavorite() {
        let beerItemVM = BeerItemVM(beer)
        mockFavorite.asyncExpectation = expectation(description: "Call")
        beerItemVM.parent = mockFavorite
        
        beerItemVM.changeFavorite()
        
        waitForExpectations(timeout: 0.5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertTrue(beerItemVM.isFavorite)
            XCTAssertEqual(self.mockFavorite.isFavorite, beerItemVM.isFavorite)
        })
        
    }
    
    func testGoPhotoBeer() {
        let beerItemVM = BeerItemVM(beer)
        mockCoordinator.asyncExpectation = expectation(description: "Call")
        beerItemVM.coordinator = mockCoordinator
        
        beerItemVM.goPhotoBeer()
        
        waitForExpectations(timeout: 0.5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockCoordinator.url?.absoluteString, beerItemVM.image)
        })
        
    }
    
    class MockFavoritesDelegate: FavoritesDelegate {
        
        var asyncExpectation: XCTestExpectation?
        var isFavorite: Bool = false
        
        func changeFavorite(favorite: BeerItemVM) {
            guard let expectation = asyncExpectation else {
                XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
                return
            }
            
            isFavorite = favorite.isFavorite
            expectation.fulfill()
        }
        
    }
    
    class MockCoordinator: CoordinatorProtocol {
        
        var asyncExpectation: XCTestExpectation?
        var url: URL?
        
        func start() {}
        
        func performTransition(transition: Any) {
            guard let expectation = asyncExpectation else {
                XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
                return
            }
            if let transition = transition as? BeerTransition {
                switch transition {
                case .goPhotoBeer(let url) :
                    self.url = url
                    expectation.fulfill()
                }
            }
        }
        
    }

}
