//
//  StyleRepository.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 04/12/2018.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON

protocol StyleRepositoryProtocol: Repository {
    typealias ResultGet = Result<[Style]?, RepositoryError>
    typealias CompletionGet = (_ result: ResultGet) -> Void
    
    @discardableResult
    func get(completion: @escaping CompletionGet) -> Cancellable
}

class StyleRepository: MoyaRepository<StyleAction>, StyleRepositoryProtocol {
    
    func get(completion: @escaping CompletionGet) -> Cancellable {
        return request(.get) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSON(data: response).dictionary,
                        let data = json["data"] {
                        
                        let style = data.arrayValue.map { Style(json: $0) }
                        completion(.success(style))
                        
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
