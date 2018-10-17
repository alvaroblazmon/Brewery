//
//  BeerListVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class BeerListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: BeerListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        prepareCollectionView()
        viewModel.reloadData()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func prepareCollectionView() {
        let nibProduct = UINib(nibName: BeerCVC.XibName, bundle: nil)
        collectionView.register(nibProduct, forCellWithReuseIdentifier: BeerCVC.ReuseIdentifier)
    }

}

extension BeerListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,
UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemVM = viewModel.itemAtIndex(indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCVC.ReuseIdentifier, for: indexPath) as? BeerCVC else {
            fatalError("The dequeued cell is not an instance of BeerCVC.")
        }
        cell.itemVM = itemVM
        cell.addShadow()
        cell.favoritesDelegate = viewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.itemAtIndex(indexPath.row) == nil {
            return CGSize(width: 0, height: 0)
        }
        let width = (collectionView.frame.width / 3) - (BeerCVC.Margin * 1.5)
        return CGSize(width: width, height: BeerCVC.Height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadNextPage(index: indexPath)
    }
    
}

extension BeerListVC: ViewModelDelegate {
    func render(state: ProcessViewState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            activityIndicator.stopAnimating()
            collectionView.reloadData()
        case .error:
            activityIndicator.stopAnimating()
            showAlertNotResult()
        case .changeItem(let index):
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    private func showAlertNotResult() {
        let alertController = UIAlertController(title: "Alert", message: "Error connection", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Accept", style: .default) { _ in self.viewModel.reloadData() }
        alertController.addAction(action1)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
