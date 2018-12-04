//
//  ViewModel.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya

protocol ViewModel: class {
    associatedtype Repository
    associatedtype ViewDelegate
    associatedtype Coordinator
    
    var repository: Repository {get set}
    var viewDelegate: ViewDelegate? {get set}
    var coordinator: Coordinator {get set}
    
    init(repository: Repository, viewDelegate: ViewDelegate, coordinator: Coordinator)
}

protocol ListViewModel: ViewModel {
    associatedtype Data
    var data: [Data] {get set}
    var count: Int {get}
    
    func itemAtIndex(_ index: Int) -> Data?
    func getData() -> [Data]
}

protocol PaginationViewModel {
    var currentPage: Int {get set}
    var totalPages: Int {get set}
    var totalItems: Int {get set}
    
    func reloadData(page: Int)
    mutating func loadNextPage(index: IndexPath)
}

extension PaginationViewModel {
    
    mutating func loadNextPage(index: IndexPath) {
        if currentPage >= totalPages {
            return
        }
        let countData = totalItems * currentPage
        if index.row == countData / 2 {
            currentPage += 1
            reloadData(page: currentPage)
        }
    }
}

class ListVM<T>: ListViewModel {
    typealias Data = T
    typealias ViewDelegate = ViewModelDelegate
    typealias Coordinator = CoordinatorProtocol
    
    internal var repository: Repository
    internal weak var viewDelegate: ViewDelegate?
    internal var coordinator: Coordinator
    internal var data: [Data]
    
    required init(repository: Repository, viewDelegate: ViewDelegate, coordinator: Coordinator) {
        self.repository = repository
        self.viewDelegate = viewDelegate
        self.coordinator = coordinator
        self.data = [Data]()
    }
    
    var count: Int {
        return data.count
    }
    
    func itemAtIndex(_ index: Int) -> Data? {
        return data[guarded: index]
    }
    
    func getData() -> [Data] {
        return data
    }
}

enum FinishType {
    case save, exit
}

protocol ParentViewModel {
    
    func finish(_ finishType: FinishType, data: Any?)
}

protocol DictionaryViewModel {
    associatedtype Data
    var data: [Data] {get set}
    var count: Int {get}
    
    func itemAtIndex(_ index: Int) -> Data?
    
    var minElementToShowDictionary: Int {get set}
    
    var dictionaryItems: [Character: [Data]] {get}
    
    var numberOfSections: Int {get}
    
    func sectionAtIndex(_ index: Int) -> Character?
    
    func numberOfElementsInSection(_ index: Int) -> Int
    
    func sectionIndexTitles() -> [String]
    
    func itemAtIndex(_ index: IndexPath) -> Data?
}

extension DictionaryViewModel {
    var isDictionary: Bool {
        return count > minElementToShowDictionary
    }
    var count: Int {
        return data.count
    }
    func itemAtIndex(_ index: Int) -> Data? {
        return data[guarded: index]
    }
    var numberOfSections: Int {
        return isDictionary ? dictionaryItems.keys.count : 1
    }
    func sectionAtIndex(_ index: Int) -> Character? {
        if !isDictionary {
            return nil
        }
        return numberOfSections > index ? dictionaryItems.keys.sorted()[index] : nil
    }
    func numberOfElementsInSection(_ index: Int) -> Int {
        if !isDictionary {
            return count
        }
        guard let key = sectionAtIndex(index),
            let items = dictionaryItems[key] else {
                return 0
        }
        return items.count
    }
    func sectionIndexTitles() -> [String] {
        if !isDictionary {
            return []
        }
        return dictionaryItems.keys.map({ String($0) }).sorted()
    }
    func itemAtIndex(_ index: IndexPath) -> Data? {
        if !isDictionary {
            return itemAtIndex(index.row)
        }
        guard let key = sectionAtIndex(index.section),
            let items = dictionaryItems[key] else {
                return nil
        }
        return items[guarded: index.row]
    }
}
