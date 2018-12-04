//
//  BeerRepository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation

enum BeerAction {
    case list(styleItemVM: StyleItemVM, page: Int)
}

protocol BeerRepositoryProtocol: Repository {
    typealias Action = BeerAction
    @discardableResult
    func request(_ action: Action, completion: @escaping Completion) -> Cancellable
}

class BeerRepository: MoyaRepository<BeerAction>, BeerRepositoryProtocol {
    func request(_ action: Action, completion: @escaping Completion) -> Cancellable {
        let cancel = SimpleCancellable()
        apiService.request(action) { result
            in self.reduce(result: result, cancel: cancel, completion: completion)
        }
        return cancel
    }
}
