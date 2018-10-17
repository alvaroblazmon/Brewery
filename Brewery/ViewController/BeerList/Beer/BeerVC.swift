//
//  BeerVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 17/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class BeerVC: UIViewController {

    var viewModel: BeerItemVM!
    
    @IBOutlet weak var heightPhotoIV: NSLayoutConstraint!
    @IBOutlet weak var photoIV: UIImageView!
    @IBOutlet weak var organicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    var initialImageHeight: CGFloat = 0
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialImageHeight = heightPhotoIV.constant
        navigationController?.isNavigationBarHidden = true
        prepareView()
    }
    
    private func prepareView() {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        organicLabel.text = viewModel.isOrganic
        abvLabel.text = viewModel.abv
        ibuLabel.text = viewModel.ibu
        if let urlImage = URL(string: viewModel.image) {
            photoIV.kf.indicatorType = .activity
            photoIV.kf.setImage(with: urlImage)
        } else {
            photoIV.image = UIImage(named: "beer")
        }
        
    }
    
    private func prepareFavorite() {
        if viewModel.isFavorite {
            favoriteButton.setImage(UIImage(named: "fav-on"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "fav-off"), for: .normal)
        }
    }
    
    @IBAction func blurViewTap(_ sender: Any) {
        if let urlImage = URL(string: viewModel.image) {
            let viewController = BeerImageVC()
            viewController.urlImage = urlImage
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func exitTap(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteTap(_ sender: Any) {
        viewModel.changeFavorite()
        prepareFavorite()
    }
}

extension BeerVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if (offset >= 0) {
            heightPhotoIV.constant = initialImageHeight
            var darken = scrollView.contentOffset.y / 300
            if darken < 0.02 { darken = 0.02 }
            blurView.alpha = darken
        } else {
            heightPhotoIV.constant = initialImageHeight + abs(offset)
            //Si el alpha es menor a esta cantidad, se deshabilitaría el TAP
            blurView.alpha = 0.02
        }
    }
    
}
