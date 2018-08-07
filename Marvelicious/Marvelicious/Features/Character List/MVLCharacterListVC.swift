//
//  MVLCharacterListVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLCharacterListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MVLNetworkManager.shared.getCharacters()
    }
}

// MARK: - Table View Delegate
extension MVLCharacterListVC: UITableViewDelegate {
    
}

// MARK: - Table View Data Source
extension MVLCharacterListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
