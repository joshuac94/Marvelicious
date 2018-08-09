//
//  MVLCharacterListVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import Lottie

protocol MVLCharacterListViewProtocol {
    func displayCharacters(_ models: [MVLCharacter])
    func isLoading(_ isLoading: Bool)
}

class MVLCharacterListVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: MVLCharacterListInteractorProtocol!
    var characters: [MVLCharacter] = []
    var selectedIndex: Int?
    var loadingView: LOTAnimationView!
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        interactor = MVLCharacterListInteractor(view: self)
    }

    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
        
        let characterNib = UINib(nibName: "MVLCharacterCell", bundle: nil)
        collectionView.register(characterNib, forCellWithReuseIdentifier: "characterCell")
        
        let loadNib = UINib(nibName: "MVLLoadCell", bundle: nil)
        collectionView.register(loadNib, forCellWithReuseIdentifier: "loadMoreCell")
        
        
        setupLoadingView()
        interactor.getCharacters(offset: characters.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = nil
    }
    
    // MARK: - Helper Methods
    fileprivate func setupLoadingView() {
        loadingView = LOTAnimationView(name: "loading")
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 85.0).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 85.0).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
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
        if indexPath.row == characters.count {
            interactor.getCharacters(offset: characters.count)
        } else {
            selectedIndex = indexPath.row
            performSegue(withIdentifier: "segueToCharacterBio", sender: self)
        }
    }
}

// MARK: - collection View Delegate Flow Layout
extension MVLCharacterListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            return CGSize(width: (collectionView.frame.size.width / 3) - 16.0,
                          height: (collectionView.frame.size.height) - 16.0)
        default:
            if indexPath.row == characters.count {
                return CGSize(width: (collectionView.frame.size.width) - 16.0,
                              height: (collectionView.frame.size.height / 6) - 16.0)
            } else {
                return CGSize(width: (collectionView.frame.size.width) - 16.0,
                              height: (collectionView.frame.size.height / 4) - 16.0)
            }
        }
    }
}

// MARK: - Collection View Data Source
extension MVLCharacterListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = self.characters.count == 0 ? 0 : self.characters.count + 1
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == characters.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadMoreCell",
                                                                for: indexPath) as? MVLLoadCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell",
                                                                for: indexPath) as? MVLCharacterCell else { return UICollectionViewCell() }
            cell.bindData(model: self.characters[indexPath.row])
            return cell
        }
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
    
    func isLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if self.characters.count == 0 {
                if isLoading {
                    self.loadingView.isHidden = false
                    self.loadingView.loopAnimation = true
                    self.loadingView.play()
                } else {
                    self.loadingView.isHidden = true
                    self.loadingView.stop()
                }
            } else {
                if let cell = self.collectionView.cellForItem(at: IndexPath(item: self.characters.count,
                                                                        section: 0)) as? MVLLoadCell {
                    cell.isLoading(isLoading)
                }
            }
        }
    }
}

