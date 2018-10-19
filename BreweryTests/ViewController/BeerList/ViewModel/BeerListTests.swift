//
//  BeerListTests.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 19/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
import Moya
@testable import Brewery

class BeerListTests: XCTestCase {
    
    let mockFavoritesStorage = MockFavoritesStorage()
    let mockCoordinator = MockCoordinator()
    let mockViewController = MockViewController()
    let provider = MoyaProviderConnection<BeerService>(stubClosure: MoyaProvider.immediatelyStub)
    var styleItemVM: StyleItemVM!
    var data: [BeerItemVM] = []

    override func setUp() {
        styleItemVM = StyleItemVM( Style(id: "1", name: "Style", description: "des") )
        let beer = Beer(id: "1", name: "Beer", description: "des", isOrganic: "Y", abv: "10", ibu: "2", icon: "icon", image: "http://pruebaimage.es")
        let beerItemVM = BeerItemVM(beer)
        data.append(beerItemVM)
        
    }
    
    func testTitle() {
        let beerListVM = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM.styleItemVM = styleItemVM
        XCTAssertEqual(beerListVM.title, styleItemVM.name)
    }
    
    func testDidSelected() {
        mockCoordinator.asyncExpectation = expectation(description: "Call")
        let beerListVM = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM.data = data
        beerListVM.didSelectItemAt(index: 0)
        
        waitForExpectations(timeout: 0.5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockCoordinator.index, 0)
            XCTAssertEqual(self.mockCoordinator.listBeerItemVM?.count, beerListVM.data.count)
        })
    }
    
    func testChangeFavorite() {
        
        mockFavoritesStorage.asyncExpectation = expectation(description: "Call Favorite")
        let beerListVM = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM.favoritesStorage = mockFavoritesStorage
        
        beerListVM.changeFavorite(favorite: data[0])
        
        waitForExpectations(timeout: 0.5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockFavoritesStorage.id, self.data[0].id)
        })
        
        mockViewController.asyncExpectation = expectation(description: "Call")
        let beerListVM2 = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM2.data = data
        beerListVM2.changeFavorite(favorite: data[0])
        
        waitForExpectations(timeout: 0.5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockViewController.status, 3)
            XCTAssertEqual(self.mockViewController.index, 0)
        })

    }
    
    func testReloadData() {
        let provider = MoyaProviderConnection<BeerService>(stubClosure: MoyaProvider.immediatelyStub)
        mockViewController.asyncExpectation = expectation(description: "Call render")
        let beerListVM = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM.styleItemVM = styleItemVM
        beerListVM.reloadData()
        
        waitForExpectations(timeout: 1, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockViewController.status, 1)
            XCTAssertEqual(beerListVM.data.count, 1)
        })
    }
    
    func testStatusCode404() {
        
        let endpointClosure = { (target: BeerService) -> Endpoint in
            return Endpoint(url: target.baseURL.absoluteString,
                            sampleResponseClosure: {.networkResponse(404, target.sampleData)},
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let provider = MoyaProviderConnection<BeerService>(endpointClosure: endpointClosure, stubClosure: MoyaProvider<BeerService>.immediatelyStub)
        
        mockViewController.asyncExpectation = expectation(description: "Call render")
        let beerListVM = BeerListVM(apiService: provider, viewDelegate: mockViewController, coordinator: mockCoordinator)
        beerListVM.styleItemVM = styleItemVM
        beerListVM.reloadData()
        
        waitForExpectations(timeout: 1, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(self.mockViewController.status, 2)
        })
    }
    
    class MockFavoritesStorage: FavoritesStorage {
        
        var asyncExpectation: XCTestExpectation?
        var id: String?
        
        func save(favorite id: String) {
            self.id = id
            guard let expectation = asyncExpectation else {
                XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
                return
            }
            expectation.fulfill()
        }
        
        func delete(favorite id: String) {
            self.id = id
            guard let expectation = asyncExpectation else {
                XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
                return
            }
            expectation.fulfill()
        }
        
        func isFavorite(favorite id: String) -> Bool {
            return true
        }
    }
    
    class MockCoordinator: CoordinatorProtocol {
        
        var asyncExpectation: XCTestExpectation?
        var index: Int?
        var listBeerItemVM: [BeerItemVM]?
        
        func start() {}
        
        func performTransition(transition: Any) {
            guard let expectation = asyncExpectation else {
                XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
                return
            }
            if let transition = transition as? StyleTransition {
                switch transition {
                case .goBeerDetails(let index, let listBeerItemVM) :
                    self.listBeerItemVM = listBeerItemVM
                    self.index = index
                    expectation.fulfill()
                case .goBeerList:
                    expectation.fulfill()
                }
            }
        }
        
    }
    
    class MockViewController: ViewModelDelegate {
        var status = 0
        var asyncExpectation: XCTestExpectation?
        var index: Int?
        
        func render(state: ProcessViewState) {
            guard let expectation = asyncExpectation else {
                return
            }
            switch state {
            case .loading:
                status = 0
            case .loaded:
                status = 1
                expectation.fulfill()
            case .error:
                status = 2
                expectation.fulfill()
            case .changeItem(let index):
                self.index = index
                status = 3
                expectation.fulfill()
            }
        }
    }

}
