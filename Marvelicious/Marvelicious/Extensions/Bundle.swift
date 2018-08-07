//
//  Bundle.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

extension Bundle {
    
    func getResourceFrom(plist: String, resource: String) -> Any? {
        guard let path = path(forResource: plist, ofType: "plist") else { return nil }
        if let dict = NSDictionary(contentsOfFile: path) as? [String : Any] {
            return dict[resource]
        }
        return nil
    }
}
