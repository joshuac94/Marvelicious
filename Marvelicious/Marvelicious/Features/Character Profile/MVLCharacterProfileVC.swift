//
//  MVLCharacterProfileVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLCharacterProfileVC: UIViewController {
    
    var character: MVLCharacter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = character?.name
    }
}
