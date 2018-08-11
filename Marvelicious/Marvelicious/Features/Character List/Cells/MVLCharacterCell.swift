//
//  MVLCharacterCell.swift
//  Marvelicious
//
//  Created by Joshua Colley on 08/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import SDWebImage

class MVLCharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        characterImageView.layer.cornerRadius = 6.0
        characterImageView.clipsToBounds = true
        characterImageView.layer.borderWidth = 0.3
        characterImageView.layer.borderColor = UIColor.gray.cgColor
        
        wrapperView.clipsToBounds = true
        wrapperView.layer.cornerRadius = 6.0
        wrapperView.layer.borderWidth = 0.3
        wrapperView.layer.borderColor = UIColor.gray.cgColor

        wrapperView.layer.shadowColor = UIColor.gray.cgColor
        wrapperView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        wrapperView.layer.shadowOpacity = 0.35
        wrapperView.layer.shadowRadius = 3.0
        wrapperView.layer.masksToBounds = false
    }
    
    func bindData(model: MVLCharacter) {
        if let path = model.thumbnail?.path, let type = model.thumbnail?.fileType {
            let urlString = "\(path)/standard_fantastic.\(type)"
            let url = URL(string: urlString)
            characterImageView.sd_setImage(with: url,
                                           placeholderImage: nil,
                                           options: .highPriority,
                                           completed: nil)
        }
        characterNameLabel.text = model.name
        if let count = model.comics?.items?.count {
            characterInfoLabel.text = "Comic apperances: \(count)"
        } else {
            characterInfoLabel.text = "Comic apperances: 0"
        }
    }
}
