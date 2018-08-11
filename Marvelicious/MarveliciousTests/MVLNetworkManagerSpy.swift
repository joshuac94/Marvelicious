//
//  MVLNetworkManagerSpy.swift
//  MarveliciousTests
//
//  Created by Joshua Colley on 11/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation
@testable import Marvelicious

class MVLNetworkManagerSpy: MVLNetworkManagerProtocol {
    var shouldFail: Bool = false
    var characterList: [MVLCharacter]!
    
    func get(endpoint: String, offset: Int, completion: @escaping (MVLServerResponse<Data>) -> Void) {
        let data: Data? = encodeData()
        
        if shouldFail {
            completion(MVLServerResponse.failed(nil))
        } else {
            completion(MVLServerResponse.success(data!))
        }
    }
    
    fileprivate func encodeData() -> Data? {
        let character = MVLCharacter(id: 001,
                                     name: "Iron Man",
                                     description: "Bloke in a metal suit",
                                     thumbnail: MVLThumbnail(path: "imagePath",
                                                             fileType: "extension"),
                                     comics: MVLComicsList(available: 1,
                                                           items: [MVLComic(name: "Comic name")]))
        let data = MVLData(data: MVLResults(results: [character]))
        return try? JSONEncoder().encode(data)
    }
}
