//
//  MVLCharacterCell.swift
//  Marvelicious
//
//  Created by Joshua Colley on 08/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLCharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(model: MVLCharacter) {
        characterNameLabel.text = model.name
        characterNameLabel.text = "\(model.id!)"
    }
}
