//
//  MVLCharacterListInteractor.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol MVLCharacterListInteractorProtocol {
    func getCharacters(offset: Int)
}

class MVLCharacterListInteractor: MVLCharacterListInteractorProtocol {
    
    var view: MVLCharacterListViewProtocol!
    var networkManager: MVLNetworkManagerProtocol!
    
    init(view: MVLCharacterListViewProtocol) {
        self.view = view
        self.networkManager = MVLNetworkManager.shared
    }
    
    // MARK: - Implement Interactor Protocol
    func getCharacters(offset: Int) {
        self.view.isLoading(true)
        let url = "https://gateway.marvel.com/v1/public/characters"
        networkManager.get(endpoint: url, offset: offset) { (response) in
            switch response {
            case .success(let data):
                self.view.isLoading(false)
                if let responseObject = try? JSONDecoder().decode(MVLData.self, from: data),
                    let characters = responseObject.data?.results {
                    self.view.displayCharacters(characters)
                } else {
                    fatalError("@ERROR: Failed to decode response")
                }
            case .failed(let error):
                self.view.isLoading(false)
                let genericErrror = "An error occured, please try again."
                self.view.displayError(message: error?.localizedDescription ?? genericErrror)
            }
        }
    }
}
