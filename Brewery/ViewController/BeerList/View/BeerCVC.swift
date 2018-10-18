//
//  BeerCVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 17/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit
import Kingfisher

class BeerCVC: UICollectionViewCell {
    
    static let XibName = "BeerCVC"
    static let ReuseIdentifier = "Beer"
    static let Height: CGFloat = 200
    static let Margin = CGFloat(16.0)

    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var itemVM: BeerItemVM? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindViewModel() {
        guard let itemVM = itemVM else {
            fatalError("BindViewModel does not has Model")
        }
        
        nameLabel.text = itemVM.name
        if let urlImage = URL(string: itemVM.icon) {
            iconIV.kf.indicatorType = .activity
            iconIV.kf.setImage(with: urlImage)
        } else {
            iconIV.image = UIImage(named: "beer")
        }
        
        if itemVM.isFavorite {
            favoriteButton.setImage(UIImage(named: "fav-on"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "fav-off"), for: .normal)
        }
        
    }
    
    func addShadow() {
        self.layer.addShadow()
        self.layer.roundCorners(radius: 2)
    }

    @IBAction func favoriteTap(_ sender: Any) {
        if let itemVM = itemVM {
            itemVM.changeFavorite()
        }
    }
}
