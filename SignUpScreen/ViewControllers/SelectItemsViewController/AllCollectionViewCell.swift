//
//  AllCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit
import SDWebImage

class AllCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func settingsCell(item: ImageModel)
    {
        self.checkboxButton.isHidden = !item.isSelected
    }
    
    var imageURL: URL? {
        didSet {
            self.imageView.image = nil
            updateUI()
        }
    }
    
    private func updateUI() {
        if let url = imageURL {
            spinner.startAnimating()
            self.imageView.sd_setImage(with: url) { (image, error, sdImageCacheType, url) in
                self.spinner.stopAnimating()
            }
        }
    }
    
}
