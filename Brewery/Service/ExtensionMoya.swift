//
//  ExtensionMoya.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Moya
import Alamofire

class MoyaProviderConnection<Target: TargetType>: MoyaProvider<Target> {
    
    let reachabilityManager = NetworkReachabilityManager()
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub) {
        
        let manager = Manager()
        
        let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true),
                                     NetworkActivityPlugin(networkActivityClosure: { change, _ in
                                        switch change {
                                        case .began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                        case .ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                        }
                                     })
        ]
        
        super.init(endpointClosure: endpointClosure, stubClosure: stubClosure, manager: manager, plugins: plugins)
    }

}

extension TargetType {
    var commonParameters: [String: String] {
            return ["key": Constant.KEY]
    }
}
