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
    
    init(rawValue: String, message: String) {
        self.rawValue = rawValue
        self.message = message
    }
    
    static let Main = Process(rawValue: "Main")
    static let Update  = Process(rawValue: "Update")
    static let Delete = Process(rawValue: "Delete")
    static let Background = Process(rawValue: "Background")
    
    static func == (lhs: Process, rhs: Process) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}

enum ProcessViewState {
    case loading(Process)
    case loaded(Process)
    case changeItem(index: Int)
    case error(Process)
}

protocol ViewModelDelegate: class {
    func render(state: ProcessViewState)
}
