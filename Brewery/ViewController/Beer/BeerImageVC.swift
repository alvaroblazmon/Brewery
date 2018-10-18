//
//  BeerImageVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 17/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class BeerImageVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoIV: UIImageView!
    var urlImage: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoIV.kf.indicatorType = .activity
        photoIV.kf.setImage(with: urlImage)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoIV
    }

    @IBAction func backTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
