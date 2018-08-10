//
//  MVLComicCell.swift
//  Marvelicious
//
//  Created by Joshua Colley on 10/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLComicCell: UITableViewCell {
    
    @IBOutlet weak var comicNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
    func bindData(comicName: String) {
        comicNameLabel.text = comicName
    }
}
