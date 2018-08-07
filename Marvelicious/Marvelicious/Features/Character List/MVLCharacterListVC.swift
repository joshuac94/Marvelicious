//
//  MVLCharacterListVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

protocol MVLCharacterListViewProtocol {
    func displayCharacters(_ models: [MVLCharacter])
}

class MVLCharacterListVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: MVLCharacterListInteractorProtocol!
    var characters: [MVLCharacter] = []
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        interactor = MVLCharacterListInteractor(view: self)
    }

    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getCharacters()
    }
}

// MARK: - Table View Delegate
extension MVLCharacterListVC: UITableViewDelegate {
    
}

// MARK: - Table View Data Source
extension MVLCharacterListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}

// MARK: - Implement View Protocol
extension MVLCharacterListVC: MVLCharacterListViewProtocol {
    func displayCharacters(_ models: [MVLCharacter]) {
        characters = models
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

