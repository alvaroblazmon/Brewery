//
//  StyleVC.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

class StyleVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: StyleVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        viewModel.reloadData()
    }
    
    /// Register the nibs cell of Filters in the tableView
    func prepareTableView() {
        let nib = UINib(nibName: StyleTVC.XibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: StyleTVC.ReuseIdentifier)
        tableView.tableFooterView = UIView()
    }

}

extension StyleVC: UITableViewDataSource, UITableViewDelegate {
    
    /// - returns: Number Of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    /// - returns: Numbers of products in viewmodel
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfElementsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let char = viewModel.sectionAtIndex(section) else {
            return nil
        }
        return String(char)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles()
    }
    
    /// - returns: A `SearchProductTVC` cell with the country in the row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StyleTVC.ReuseIdentifier, for: indexPath) as? StyleTVC  else {
            fatalError("The dequeued cell is not an instance of SearchProductTVC.")
        }
        
        cell.itemVM = viewModel.itemAtIndex(indexPath)
        
        return cell
        
    }
    
    /// Call didSelectItemAt of the viewModel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath)
    }
    
}

extension StyleVC: ViewModelDelegate {
    func render(state: ProcessViewState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error:
            activityIndicator.stopAnimating()
        }
    }
}
