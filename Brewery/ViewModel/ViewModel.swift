//
//  ViewModel.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya

protocol ViewModel: class {
    associatedtype ApiService
    associatedtype ViewDelegate
    associatedtype Coordinator
    
    var apiService: ApiService {get set}
    var viewDelegate: ViewDelegate? {get set}
    var coordinator: Coordinator {get set}
    
    init(apiService: ApiService, viewDelegate: ViewDelegate, coordinator: Coordinator)
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
    /// Next page of the products
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

class ListVM<T, Z: TargetType>: ListViewModel {
    typealias Data = T
    typealias ApiService = MoyaProviderConnection<Z>
    typealias ViewDelegate = ViewModelDelegate
    typealias Coordinator = CoordinatorProtocol
    
    internal var apiService: ApiService
    internal weak var viewDelegate: ViewDelegate?
    internal var coordinator: Coordinator
    internal var data: [Data]
    
    required init(apiService: ApiService, viewDelegate: ViewDelegate, coordinator: Coordinator) {
        self.apiService = apiService
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
    /// Finish
    func finish(_ finishType: FinishType, data: Any?)
}

protocol DictionaryViewModel {
    associatedtype Data
    var data: [Data] {get set}
    /// Count of the data
    var count: Int {get}
    /// - return: Item at Index in data
    func itemAtIndex(_ index: Int) -> Data?
    /// Minimum elements to show the data as dictionary
    var minElementToShowDictionary: Int {get set}
    /// Dictionary of data with the fists character as key
    var dictionaryItems: [Character: [Data]] {get}
    /// Number of sections of data
    var numberOfSections: Int {get}
    /// - return: Section At Index. If data are NOT shown as Dictionary then return nil
    func sectionAtIndex(_ index: Int) -> Character?
    /// - return: Number of elements in section. If data are NOT shown as Dictionary then return total number of items
    func numberOfElementsInSection(_ index: Int) -> Int
    /// - return: Section Index Titles. If data are NOT shown as Dictionary return a empty array
    func sectionIndexTitles() -> [String]
    /// Use when the data are shown as Dictionary
    /// - return: Item at index
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
