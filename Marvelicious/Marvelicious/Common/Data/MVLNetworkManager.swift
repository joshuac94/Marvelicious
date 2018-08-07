//
//  MVLNetworkManager.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol MVLNetworkManagerProtocol {
    func get(url: String)
}

class MVLNetworkManager: MVLNetworkManagerProtocol {
    var apiKey: String!
    static let shared: MVLNetworkManager = MVLNetworkManager()
    
    init() {
        guard let key = Bundle.main.getResourceFrom(plist: "Info", resource: "apiKey") as? String else { return }
        self.apiKey = key
    }
    
    func get(url: String) {
    }
}
