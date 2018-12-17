//
//  StyleService.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya

enum StyleAction {
    case get
}

extension StyleAction: TargetType {
    
    var baseURL: URL { return URL(string: Constant.URLAPI)! }
    var path: String {
        switch self {
        case .get:
            return "styles"
        }
    }
    var method: Moya.Method {
        switch self {
        case .get:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .get:
            return .requestParameters(parameters: commonParameters, encoding: URLEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .get:
            return Data()
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
