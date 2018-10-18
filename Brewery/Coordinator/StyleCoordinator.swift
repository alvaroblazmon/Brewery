//
//  StyleCoordinator.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

enum StyleTransition {
    case goBeerList(styleItemVM: StyleItemVM)
    case goBeerDetails(index: Int, listBeerItemVM: [BeerItemVM])
}

class StyleCoordinator: CoordinatorProtocol {
    
    typealias NavViewController = UINavigationController
    var navigationController: NavViewController
    
    init(navigationController: NavViewController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let styleVC = StyleVC()
        let viewModel = StyleVM(apiService: MoyaProviderConnection<StyleService>(), viewDelegate: styleVC, coordinator: self)
        styleVC.viewModel = viewModel
        
        navigationController.setViewControllers([styleVC], animated: false)
    }
    
    func performTransition(transition: Any) {
        if let trasition = transition as? StyleTransition {
            switch trasition {
                
            case .goBeerList(let styleItemVM):
                let viewController = BeerListVC()
                let viewModel = BeerListVM(apiService: MoyaProviderConnection<BeerService>(), viewDelegate: viewController, coordinator: self)
                viewModel.styleItemVM = styleItemVM
                viewModel.favoritesStorage = Storage.Favorites.init()
                viewController.viewModel = viewModel
                navigationController.pushViewController(viewController, animated: true)
                
            case .goBeerDetails(let index, let listBeerItemVM):
                let childNavigationController = UINavigationController()
                let beerCoordinator = BeerCoordinator(navigationController: childNavigationController,
                                                      selectedBeer: index,
                                                      listBeerItemVM: listBeerItemVM)
                beerCoordinator.start()
                navigationController.present(childNavigationController, animated: true, completion: nil)
                
            }
        }
    }
}
