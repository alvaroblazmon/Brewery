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
    
    typealias NavViewController = UIViewController
    
    var navigationController: NavViewController?
    var tabBarController: UITabBarController
    var window: UIWindow?
    
    required init(navigationController: NavViewController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    required init(tabBarController: UITabBarController, window: UIWindow?) {
        self.tabBarController = UITabBarController()
        self.window = window
    }
    
    func start() {
        
        //tabBarController.tabBar.tintColor = UIColor.Padel.Purple
        
        for viewTab in ViewsInTab.allCases {
            let viewNVC = UINavigationController()
            viewNVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Yellow")!]
            viewNVC.navigationBar.tintColor = UIColor(named: "Yellow")
            viewNVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Yellow")!]
            
            var coordinator: CoordinatorProtocol
            switch viewTab {
            case ViewsInTab.home:
                coordinator = StyleCoordinator(navigationController: viewNVC)
                viewNVC.tabBarItem = UITabBarItem(title: "Liguillas", image: UIImage(named: "slider_products"), tag: 0)
            case ViewsInTab.favorites:
                coordinator = StyleCoordinator(navigationController: viewNVC)
                viewNVC.tabBarItem = UITabBarItem(title: "Info", image: UIImage(named: "slider_products"), tag: 1)
            }
            coordinator.start()
            if tabBarController.viewControllers == nil {
                tabBarController.viewControllers = [viewNVC]
            } else {
                tabBarController.viewControllers?.append(viewNVC)
            }
        }
        
        if let navigationController = navigationController {
            navigationController.present(tabBarController, animated: false, completion: nil)
        }
        
        if let window = window {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    func performTransition(transition: Any) {
    }
    
}

