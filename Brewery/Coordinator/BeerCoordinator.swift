//
//  BeerCoordinator.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit
import Moya

enum BeerTransition {
    case goPhotoBeer(url: URL)
}

protocol BeerCoordinatorProtocol: CoordinatorProtocol {
    func performTransition(transition: BeerTransition)
}

class BeerCoordinator: BeerCoordinatorProtocol {
    
    typealias NavViewController = UINavigationController
    var navigationController: NavViewController
    var listBeerItemVM: [BeerItemVM]
    let selectedBeer: Int
    
    init(navigationController: NavViewController, selectedBeer: Int, listBeerItemVM: [BeerItemVM]) {
        self.navigationController = navigationController
        self.listBeerItemVM = listBeerItemVM
        self.selectedBeer = selectedBeer
    }
    
    func start() {
        let viewController = BeerPVC.initViewController()
        let viewModel = BeerPVCVM(index: selectedBeer, data: listBeerItemVM, coordinator: self)
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func performTransition(transition: BeerTransition) {
        switch transition {
        case .goPhotoBeer(let url):
            let viewController = BeerImageVC()
            viewController.urlImage = url
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
}
