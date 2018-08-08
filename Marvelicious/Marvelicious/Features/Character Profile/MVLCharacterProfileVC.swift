//
//  MVLCharacterProfileVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLCharacterProfileVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var character: MVLCharacter?
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = character?.name
    }
    
    // MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
