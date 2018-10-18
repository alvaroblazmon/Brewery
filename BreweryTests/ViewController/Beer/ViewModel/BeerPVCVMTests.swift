//
//  BeerPVCVMTests.swift
//  BreweryTests
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import XCTest
@testable import Brewery

class BeerPVCVMTests: XCTestCase {

    var data: [BeerItemVM] = []
    let mockCoordinator = MockCoordinator()
    
    override func setUp() {
        let beer1 = Beer(id: "1", name: "", description: "", isOrganic: "", abv: "", ibu: "", icon: "", image: "")
        let beer2 = Beer(id: "2", name: "", description: "", isOrganic: "", abv: "", ibu: "", icon: "", image: "")
        let beer3 = Beer(id: "3", name: "", description: "", isOrganic: "", abv: "", ibu: "", icon: "", image: "")
        
        let beerItemVM1 = BeerItemVM(beer1)
        let beerItemVM2 = BeerItemVM(beer2)
        let beerItemVM3 = BeerItemVM(beer3)
        
        data.append(beerItemVM1)
        data.append(beerItemVM2)
        data.append(beerItemVM3)
    }

    func testNewBeerPVCVM() {
        let beerPVCVM = BeerPVCVM(index: 0, data: data, coordinator: mockCoordinator)
        let beerVC = BeerVC()
        beerVC.viewModel = data[0]
        
        XCTAssertEqual(beerPVCVM.count, 3)
        XCTAssertEqual(beerPVCVM.first?.viewModel.id, beerVC.viewModel.id)
    }
    
    func testViewControllerBefore() {
        let beerPVCVM = BeerPVCVM(index: 0, data: data, coordinator: mockCoordinator)
        let beerVC = BeerVC()
        beerVC.viewModel = data[2]
        
        let beforeBeerVC = BeerVC()
        beforeBeerVC.viewModel = data[1]
        
        XCTAssertEqual(beerPVCVM.viewController(before: beerVC)?.viewModel.id, beforeBeerVC.viewModel.id)
    }
    
    func testViewControllerBeforeFails() {
        let beerPVCVM = BeerPVCVM(index: 0, data: data, coordinator: mockCoordinator)
        let beerVC = BeerVC()
        beerVC.viewModel = data[0]
        
        XCTAssertNil(beerPVCVM.viewController(before: beerVC))
        XCTAssertNil(beerPVCVM.viewController(before: UIViewController()))
    }
    
    func testViewControllerAfter() {
        let beerPVCVM = BeerPVCVM(index: 0, data: data, coordinator: mockCoordinator)
        let beerVC = BeerVC()
        beerVC.viewModel = data[0]
        
        let afterBeerVC = BeerVC()
        afterBeerVC.viewModel = data[1]
        
        XCTAssertEqual(beerPVCVM.viewController(after: beerVC)?.viewModel.id, afterBeerVC.viewModel.id)
    }
    
    func testViewControllerAfterFails() {
        let beerPVCVM = BeerPVCVM(index: 0, data: data, coordinator: mockCoordinator)
        let beerVC = BeerVC()
        beerVC.viewModel = data[2]
        
        XCTAssertNil(beerPVCVM.viewController(after: beerVC))
        XCTAssertNil(beerPVCVM.viewController(after: UIViewController()))
    }
    
    class MockCoordinator: CoordinatorProtocol {
        func start() {}
        func performTransition(transition: Any) {}
    }

}
