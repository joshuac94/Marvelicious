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
    @IBOutlet weak var textWrapperView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        characterImageView.layer.cornerRadius = 12.0
        characterImageView.clipsToBounds = true
        
        wrapperView.clipsToBounds = true
        wrapperView.layer.cornerRadius = 12.0
        wrapperView.layer.borderColor = UIColor.black.cgColor
        wrapperView.layer.borderWidth = 2.0
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
