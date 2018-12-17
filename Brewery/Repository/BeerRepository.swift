//
//  BeerRepository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON

protocol BeerRepositoryProtocol: Repository {
    
    typealias ResultList = Result<(beers: [Beer], totalPages: Int)?, RepositoryError>
    typealias CompletionList = (_ result: ResultList) -> Void
    
    @discardableResult
    func list(styleItemVM: StyleItemVM, page: Int, completion: @escaping CompletionList) -> Cancellable
}

class BeerRepository: MoyaRepository<BeerAction>, BeerRepositoryProtocol {
    
    func list(styleItemVM: StyleItemVM, page: Int, completion: @escaping CompletionList) -> Cancellable {
        return request(.list(styleItemVM: styleItemVM, page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSON(data: response).dictionary,
                        let data = json["data"] {
                        
                        let beers = data.arrayValue.map { Beer(json: $0) }
                        let totalPages = json["numberOfPages"]?.intValue ?? 0
                        completion(.success((beers: beers, totalPages: totalPages)))
                        
                    } else {
                        completion(.success(nil))
                    }
                } catch {
                    completion(.failure(.badJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
