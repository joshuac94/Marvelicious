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
    var selectedIndex: Int?
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        interactor = MVLCharacterListInteractor(view: self)
    }

    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getCharacters(offset: characters.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = nil
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else { return }
        switch segue.identifier! {
        case "segueToCharacterBio":
            if let vc = segue.destination as? MVLCharacterProfileVC,
                let index = selectedIndex {
                vc.character = characters[index]
            }
        default: break
        }
    }
}

// MARK: - Table View Delegate
extension MVLCharacterListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segueToCharacterBio", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Table View Data Source
extension MVLCharacterListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == characters.count - 1 {
            interactor.getCharacters(offset: characters.count)
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
}

// MARK: - Implement View Protocol
extension MVLCharacterListVC: MVLCharacterListViewProtocol {
    func displayCharacters(_ models: [MVLCharacter]) {
        models.forEach { (model) in
            characters.append(model)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

