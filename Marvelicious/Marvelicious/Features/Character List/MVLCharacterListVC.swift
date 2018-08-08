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
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        let characterNib = UINib(nibName: "MVLCharacterCell", bundle: nil)
        collectionView.register(characterNib, forCellWithReuseIdentifier: "characterCell")
        collectionView.contentInset = UIEdgeInsetsMake(16.0, 16.0, 16.0, 16.0)
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

// MARK: - Collection View Delegate
extension MVLCharacterListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segueToCharacterBio", sender: self)
    }
}

// MARK: - collection View Delegate Flow Layout
extension MVLCharacterListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 32.0,
                      height: (collectionView.frame.size.height / 2.0) - 48.0)
    }
}

// MARK: - Collection View Data Source
extension MVLCharacterListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell",
                                                            for: indexPath) as? MVLCharacterCell else { return UICollectionViewCell() }
        cell.bindData(model: self.characters[indexPath.row])
        return cell
    }
}

// MARK: - Implement View Protocol
extension MVLCharacterListVC: MVLCharacterListViewProtocol {
    func displayCharacters(_ models: [MVLCharacter]) {
        models.forEach { (model) in
            self.characters.append(model)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

