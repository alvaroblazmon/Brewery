//
//  StyleRepository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation

enum StyleAction {
    case get
}

protocol StyleRepositoryProtocol: Repository {
    typealias Action = StyleAction
    @discardableResult
    func request(_ action: Action, completion: @escaping Completion) -> Cancellable
}

class StyleRepository: MoyaRepository<StyleAction>, StyleRepositoryProtocol {
    func request(_ action: Action, completion: @escaping Completion) -> Cancellable {
        let cancel = SimpleCancellable()
        apiService.request(action) { result in
            self.reduce(result: result, cancel: cancel, completion: completion)
        }
        return cancel
    }
}
