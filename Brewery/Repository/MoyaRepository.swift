//
//  MoyaRepository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya
import Result

class MoyaRepository<T: TargetType> {
    let apiService = MoyaProviderConnection<T>()
    
    internal func reduce(result: Result<Moya.Response, MoyaError>, cancel: Cancellable, completion: Repository.Completion) {
        
        if cancel.isCancelled { return }
        completion(result.reduce())
        
    }
}

extension Result where T == Moya.Response, Error == MoyaError {
    func reduce() -> Repository.ResultRepository {
        switch self {
        case let .success(response):
            do {
                _ = try response.filterSuccessfulStatusCodes()
                return .success(response.data)
            } catch {
                return .failure(.simpleError)
            }
        case .failure:
            return .failure(.simpleError)
        }
    }
}

