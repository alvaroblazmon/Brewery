//
//  MainCoordinator.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    enum ViewsInTab: CaseIterable {
        case home, favorites
    }
    
    typealias NavViewController = UINavigationController
    
    var navigationController: NavViewController
    var window: UIWindow?
    
    required init(navigationController: NavViewController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Brewery.Yellow]
        navigationController.navigationBar.tintColor = UIColor.Brewery.Yellow
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Brewery.Yellow]
        
        let coordinator = StyleCoordinator(navigationController: navigationController)
        coordinator.start()
        
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    func performTransition(transition: Any) {
    }
    
}
