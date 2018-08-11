//
//  MVLCharacterListViewTests.swift
//  MarveliciousTests
//
//  Created by Joshua Colley on 11/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import XCTest
@testable import Marvelicious

class MVLCharacterListViewTests: XCTestCase {
    
    var sut: MVLCharacterListVC!
    var interactorSpy: MVLCharacterListInteractorSpy!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MVLCharacterListVC")
            as? MVLCharacterListVC else { fatalError("Unable to create MVLCharacterListVC") }
        sut = vc
        
        interactorSpy = MVLCharacterListInteractorSpy()
        sut.interactor = interactorSpy
        
        window = UIWindow()
    }
    
//    func displayError(message: String)
//    func isLoading(_ isLoading: Bool)
    
    func testDidCallGetCharacters() {
        // Given
        window.addSubview(sut.view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorSpy.didCallGetCharacters)
    }
    
    func testDisplayCharacter() {
        // Given
        window.addSubview(sut.view)
        let character = MVLCharacter(id: 001,
                                     name: "Iron Man",
                                     description: "Bloke in a metal suit",
                                     thumbnail: MVLThumbnail(path: "imagePath",
                                                             fileType: "extension"),
                                     comics: MVLComicsList(available: 1,
                                                           items: [MVLComic(name: "Comic name")]))
        
        // When
        sut.displayCharacters([character])
        
        // Then
        let index = IndexPath(row: 0, section: 0)
        let cell = sut.collectionView(sut.collectionView, cellForItemAt: index) as? MVLCharacterCell
        
        XCTAssertEqual("Iron Man", cell?.characterNameLabel.text!)
        XCTAssertEqual("Comic apperances: 1", cell?.characterInfoLabel.text!)
    }
}

class MVLCharacterListInteractorSpy: MVLCharacterListInteractorProtocol {
    var didCallGetCharacters: Bool = false
    
    func getCharacters(offset: Int) {
        didCallGetCharacters = true
    }
}

