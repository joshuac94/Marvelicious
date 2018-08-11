//
//  MVLCharacterProfileVC.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import SDWebImage

enum MVLProfileSection: Int {
    case bio
    case comics
}

class MVLCharacterProfileVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var character: MVLCharacter?
    
    // MARK: - View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        characterImageView.layer.cornerRadius = 6.0
        characterImageView.clipsToBounds = true
        characterImageView.layer.borderWidth = 0.3
        characterImageView.layer.borderColor = UIColor.gray.cgColor
        if let path = character?.thumbnail?.path, let type = character?.thumbnail?.fileType {
            let urlString = "\(path)/standard_fantastic.\(type)"
            let url = URL(string: urlString)
            
            characterImageView.sd_setImage(with: url,
                                           completed: nil)
        }
        characterNameLabel.text = character?.name
        if let count = character?.comics?.items?.count {
            characterInfoLabel.text = "Comic apperances: \(count)"
        } else {
            characterInfoLabel.text = "Comic apperances: 0"
        }
        
        let bioNib = UINib(nibName: "MVLBioCell", bundle: nil)
        tableView.register(bioNib, forCellReuseIdentifier: "bioCell")
        
        let comicNib = UINib(nibName: "MVLComicCell", bundle: nil)
        tableView.register(comicNib, forCellReuseIdentifier: "comicCell")
    }
    
    // MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    fileprivate func setupBioCell(table: UITableView, index: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "bioCell",
                                                   for: index) as? MVLBioCell else {
            return UITableViewCell()
        }
        cell.bindData(bio: character?.description ?? "")
        return cell
    }
    
    fileprivate func setupComicCell(table: UITableView, index: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "comicCell",
                                                   for: index) as? MVLComicCell else {
                                                    return UITableViewCell()
        }
        cell.bindData(comicName: character?.comics?.items?[index.row].name ?? "")
        return cell
    }
}

// MARK: - Table View Delegate
extension MVLCharacterProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35.0))
        view.backgroundColor = self.view.backgroundColor
        
        let label = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.frame.width, height: 35.0))
        label.textColor = UIColor.darkText
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        
        guard let section = MVLProfileSection(rawValue: section) else { return nil }
        switch section {
        case .bio: label.text = "Biography"
        case .comics: label.text = "Comics"
        }
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
}

// MARK: - Table View Data Source
extension MVLCharacterProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MVLProfileSection(rawValue: section) else { return 0 }
        switch section {
        case .bio: return 1
        case .comics: return character?.comics?.items?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if character?.comics?.items?.count != 0 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MVLProfileSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .bio: return setupBioCell(table: tableView, index: indexPath)
        case .comics: return setupComicCell(table: tableView, index: indexPath)
        }
    }
}
