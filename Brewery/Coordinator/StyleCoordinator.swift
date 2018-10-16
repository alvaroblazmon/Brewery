//
//  StyleCoordinator.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

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
    }
}
