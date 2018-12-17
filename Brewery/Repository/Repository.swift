//
//  Repository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Result

protocol Cancellable {
    
    /// A Boolean value stating whether a request is cancelled.
    var isCancelled: Bool { get }
    
    /// Cancels the represented request.
    func cancel()
}

class SimpleCancellable: Cancellable {
    var isCancelled = false
    func cancel() {
        isCancelled = true
    }
}

enum RepositoryError: Error {
    case simpleError, badJSON
}

protocol Repository {
    typealias ResultRepository = Result<Data, RepositoryError>
    typealias Completion = (_ result: ResultRepository) -> Void
}
