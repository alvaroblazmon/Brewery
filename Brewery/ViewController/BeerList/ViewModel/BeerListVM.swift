//
//  BeerListVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

protocol FavoritesDelegate: class {
    func changeFavorite(favorite: BeerItemVM)
}

class BeerListVM: ListVM<BeerItemVM, BeerRepositoryProtocol, StyleCoordinatorProtocol>, PaginationViewModel, FavoritesDelegate {
    var currentPage: Int = 1
    var totalPages: Int = 0
    // En la documentación de Brewery indica que el total de Items de cada página es 50
    var totalItems: Int = 50
    
    var styleItemVM: StyleItemVM!
    var favoritesStorage: FavoritesStorage?
    
    var title: String {
        return styleItemVM.name
    }
    
    func reloadData(page: Int = 1) {
        guard let viewDelegate = self.viewDelegate else {
            fatalError("ViewModel without view delegate")
        }
        if page == 1 {
            viewDelegate.render(state: .loading(Process.Main))
        }
        
        repository.list(styleItemVM: styleItemVM, page: page) { result in
            switch result {
            case let .success(response):
                if let response = response {
                    self.data.append(contentsOf: response.beers.map {
                        let beerItemVM = BeerItemVM($0)
                        beerItemVM.isFavorite = self.favoritesStorage?.isFavorite(favorite: beerItemVM.id) ?? false
                        beerItemVM.parent = self
                        return beerItemVM
                    })
                    self.totalPages = response.totalPages
                }
                
                viewDelegate.render(state: .loaded(Process.Main))
            case .failure:
                viewDelegate.render(state: .error(Process.Main))
            }
            
        }
    }
    
    func didSelectItemAt(index: Int) {
        if index < data.count {
            let transition = StyleTransition.goBeerDetails(index: index, listBeerItemVM: data)
            coordinator.performTransition(transition: transition)
        }
    }
    
    func changeFavorite(favorite: BeerItemVM) {
        if favorite.isFavorite {
            favoritesStorage?.save(favorite: favorite.id)
        } else {
            favoritesStorage?.delete(favorite: favorite.id)
        }
        if let index = data.firstIndex(where: { $0.id == favorite.id }) {
            viewDelegate?.render(state: .changeItem(index: index))
        }
    }
    
}
