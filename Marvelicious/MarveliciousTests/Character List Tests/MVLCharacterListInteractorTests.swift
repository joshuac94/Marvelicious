//
//  MVLCharacterListInteractorTests.swift
//  MarveliciousTests
//
//  Created by Joshua Colley on 11/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import XCTest
@testable import Marvelicious

class MVLCharacterListInteractorTests: XCTestCase {
    
    var sut: MVLCharacterListInteractor!
    var viewSpy: MVLCharacterListViewSpy!
    var networkSpy: MVLNetworkManagerSpy!
    
    override func setUp() {
        super.setUp()
        
        viewSpy = MVLCharacterListViewSpy()
        sut = MVLCharacterListInteractor(view: viewSpy)
        
        networkSpy = MVLNetworkManagerSpy()
        sut.networkManager = networkSpy
    }
    
    func testDidCallDisplayCharacters() {
        // Given
        let offset = 0
        networkSpy.shouldFail = false
        
        // When
        sut.getCharacters(offset: offset)
        
        // Then
        XCTAssertTrue(viewSpy.didCallDisplayCharacters)
    }
}

class MVLCharacterListViewSpy: MVLCharacterListViewProtocol {
    var didCallDisplayCharacters: Bool = false
    
    func displayCharacters(_ models: [MVLCharacter]) {
        didCallDisplayCharacters = true
    }
    
    func displayError(message: String) {
    }
    
    func isLoading(_ isLoading: Bool) {
    }
}


