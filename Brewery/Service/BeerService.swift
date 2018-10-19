//
//  BeerService.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya

enum BeerService {
    case list(styleItemVM: StyleItemVM, page: Int)
}

extension BeerService: TargetType {
    
    var baseURL: URL { return URL(string: Constant.URLAPI)! }
    var path: String {
        switch self {
        case .list:
            return "beers"
        }
    }
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .list(let styleItemVM, let page):
            var parameters = styleItemVM.getFormData()
            parameters += ["p": String(page)]
            parameters += commonParameters
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .list:
            let json = "{\"data\": [" +
            "{\"id\": \"1\",\"name\": \"Beer\",\"description\": \"descripcion\",\"isOrganic\": \"Y\"," +
            "\"abv\": \"10\",\"ibu\": \"2\", \"labels\": {\"medium\": \"icon\",\"large\": \"image\"}}]}"
            return json.utf8Encoded

        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
