//
//  BeerCoordinator.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit
import Moya

class BeerCoordinator: CoordinatorProtocol {
    
    typealias NavViewController = UINavigationController
    var navigationController: NavViewController
    var beerItemVM: BeerItemVM
    
    init(navigationController: NavViewController, beerItemVM: BeerItemVM) {
        self.navigationController = navigationController
        self.beerItemVM = beerItemVM
    }
    
    func start() {
        let viewController = BeerVC()
        viewController.viewModel = beerItemVM
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func performTransition(transition: Any) {}
    
}
