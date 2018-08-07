//
//  MVLCharacterListInteractor.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

protocol MVLCharacterListInteractorProtocol {
    func getCharacters()
}

class MVLCharacterListInteractor: MVLCharacterListInteractorProtocol {
    
    var view: MVLCharacterListViewProtocol!
    
    init(view: MVLCharacterListViewProtocol) {
        self.view = view
    }
    
    // MARK: - Implement Interactor Protocol
    func getCharacters() {
        let url = "https://gateway.marvel.com/v1/public/characters"
        MVLNetworkManager.shared.get(endpoint: url, data: nil) { (response) in
            switch response {
            case .success(let data):
                if let characters = try? JSONDecoder().decode(MVLData.self, from: data) {
                    debugPrint(characters.data)
//                    self.view.displayCharacters(characters)
                } else {
                    fatalError("@ERROR: Failed to decode response")
                }
                
            case .failed(_):
                break
            }
        }
    }
}
