//
//  StyleVM.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import SwiftyJSON
import Moya

class StyleVM: ListVM<StyleItemVM, StyleService>, DictionaryViewModel {
    
    var minElementToShowDictionary: Int = 15
    var dictionaryItems: [Character: [StyleItemVM]] = [:]
    
    func reloadData() {
        guard let viewDelegate = self.viewDelegate else {
            fatalError("ViewModel without view delegate")
        }
        viewDelegate.render(state: .loading)
        
        apiService.request(.get) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    _ = try moyaResponse.filterSuccessfulStatusCodes()
                    if let json = try JSON(data: moyaResponse.data).dictionary,
                        let data = json["data"] {
                            self.data = data.arrayValue.map { StyleItemVM(Style(json: $0)) }
                            self.dictionaryItems = Dictionary(grouping: self.data,
                                                              by: { $0.name.formattedFirstChar })
                    }
                    
                    viewDelegate.render(state: .loaded(Process.Main))
                } catch {
                    viewDelegate.render(state: .error(.connectionError))
                }
            case .failure:
                viewDelegate.render(state: .error(.connectionError))
            }
        }
    }
    
    func didSelectItemAt(index: IndexPath) {
        if let styleItemVM = itemAtIndex(index) {
            let transition = StyleTransition.goBeerList(styleItemVM: styleItemVM)
            coordinator.performTransition(transition: transition)
        }
    }
    
}
