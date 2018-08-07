//
//  MVLNetworkManager.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation
import StringMD5

// Response Sealed Class
enum MVLServerResponse<T> {
    case success(T)
    case failed(Error)
}

protocol MVLNetworkManagerProtocol {
    func get(endpoint: String, offset: Int, completion: @escaping (MVLServerResponse<Data>) -> Void)
}

class MVLNetworkManager: MVLNetworkManagerProtocol {
    var publicKey: String!
    var privateKey: String!
    
    static let shared: MVLNetworkManager = MVLNetworkManager()
    
    init() {
        guard let publicKey = Bundle.main.getResourceFrom(plist: "Info", resource: "publicKey") as? String,
            let privateKey = Bundle.main.getResourceFrom(plist: "Info", resource: "privateKey") as? String else { return }
        
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    func get(endpoint: String, offset: Int, completion: @escaping (MVLServerResponse<Data>) -> Void) {
        
        guard let url = setupURL(url: endpoint, offset: offset) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error { 
                completion(MVLServerResponse.failed(error))
                return
            }
            guard let data = data else { return }
            completion(MVLServerResponse.success(data))
        }
        task.resume()
    }
    
    // MARK: - Helper Methods
    fileprivate func setupURL(url: String, offset: Int) -> URL? {
        let timestamp = Date().timeIntervalSince1970.description
        let hash = "\(timestamp)\(privateKey!)\(publicKey!)".md5
        
        var urlComposite = URLComponents(string: url)
        urlComposite?.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        guard let url = urlComposite?.url else { return nil }
        
        return url
    }
}
