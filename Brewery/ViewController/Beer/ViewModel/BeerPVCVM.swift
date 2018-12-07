//
//  BeerPVCVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class BeerPVCVM {
    
    let data: [BeerItemVM]
    let index: Int
    let coordinator: BeerCoordinatorProtocol
    
    init(index: Int, data: [BeerItemVM], coordinator: BeerCoordinatorProtocol) {
        self.data = data
        self.index = index
        self.coordinator = coordinator
    }
    
    var count: Int {
        return data.count
    }
    
    var first: BeerVC? {
        return getBeerVC(index: index)
    }
    
    private func getBeerVC(index: Int) -> BeerVC? {
        guard let beerItemVM = data[guarded: index] else {
            return nil
        }
        beerItemVM.coordinator = coordinator
        let viewController = BeerVC()
        viewController.viewModel = beerItemVM
        return viewController
    }
    
    func viewController(before viewController: UIViewController) -> BeerVC? {
        guard let viewController = viewController as? BeerVC else {
            return nil
        }
        
        let index = data.map { $0.id }.firstIndex(of: viewController.viewModel.id) ?? 0
        
        if index == 0 {
            return nil
        }
        
        return getBeerVC(index: index - 1)
    }
    
    func viewController(after viewController: UIViewController) -> BeerVC? {
        guard let viewController = viewController as? BeerVC else {
            return nil
        }
        
        let index = data.map { $0.id }.firstIndex(of: viewController.viewModel.id) ?? data.count
        
        if (index + 1) >= data.count {
            return nil
        }
        
        return getBeerVC(index: index + 1)
    }
    
}
