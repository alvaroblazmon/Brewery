//
//  StyleTVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class StyleTVC: UITableViewCell {
    
    static let XibName = "StyleTVC"
    static let ReuseIdentifier = "Style"
    
    var itemVM: StyleItemVM? {
        didSet {
            bindViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func bindViewModel() {
        guard let itemVM = itemVM else {
            fatalError("BindViewModel does not has Model")
        }
        
        textLabel?.text = itemVM.name
        
    }
    
}
