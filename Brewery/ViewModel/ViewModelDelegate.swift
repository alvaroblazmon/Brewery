//
//  ViewModelDelegate.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import UIKit

struct Process: Equatable {
    
    var rawValue: String
    var message: String = ""
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let Main  = Process(rawValue: "Main")
    
    static func == (lhs: Process, rhs: Process) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}

enum ProcessViewState {
    case loading
    case loaded(Process)
    case error(ProcessError)
}

enum ProcessError {
    case connectionError
}

protocol ViewModelDelegate: class {
    func render(state: ProcessViewState)
}
