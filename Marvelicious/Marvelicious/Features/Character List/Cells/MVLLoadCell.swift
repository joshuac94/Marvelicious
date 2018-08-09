//
//  MVLLoadCell.swift
//  Marvelicious
//
//  Created by Joshua Colley on 09/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import UIKit
import Lottie

protocol MVLLoadCellDelegate {
    func isLoading(_ isLoading: Bool)
}

class MVLLoadCell: UICollectionViewCell, MVLLoadCellDelegate {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var label: UILabel!
    
    var loadingView: LOTAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.layer.cornerRadius = 12.0
        wrapperView.layer.borderColor = UIColor.black.cgColor
        wrapperView.layer.borderWidth = 2.0
        
        setupLoadingView()
    }
    
    fileprivate func setupLoadingView() {
        loadingView = LOTAnimationView(name: "loading")
        loadingView.isHidden = true
        wrapperView.addSubview(loadingView)

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
    }
    
    func isLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.label.isHidden = true
                
                self.loadingView.isHidden = false
                self.loadingView.loopAnimation = true
                self.loadingView.play()
            } else {
                self.label.isHidden = false
                
                self.loadingView.isHidden = true
                self.loadingView.stop()
            }
        }
    }
}
