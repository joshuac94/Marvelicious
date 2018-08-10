//
//  MVLBioCell.swift
//  Marvelicious
//
//  Created by Joshua Colley on 10/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit

class MVLBioCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        textView.backgroundColor = UIColor.clear
    }
    
    func bindData(bio: String) {
        let nullState = "There is no description of this character."
        textView.text = bio == "" ? nullState : bio
    }
}
