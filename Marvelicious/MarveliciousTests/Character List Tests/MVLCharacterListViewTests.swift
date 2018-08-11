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
    
    func testDidCallGetCharacters() {
        // Given
        window.addSubview(sut.view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorSpy.didCallGetCharacters)
    }
}

class MVLCharacterListInteractorSpy: MVLCharacterListInteractorProtocol {
    var didCallGetCharacters: Bool = false
    
    func getCharacters(offset: Int) {
        didCallGetCharacters = true
    }
}

