//
//  BeerPVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 18/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class BeerPVC: UIPageViewController {
    
    static func initViewController() -> BeerPVC {
        return BeerPVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 10])
    }

    var viewModel: BeerPVCVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        dataSource = self
        if let first = viewModel.first {
            setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
    }

}

extension BeerPVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.viewController(before: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.viewController(after: viewController)
    }
    
}
