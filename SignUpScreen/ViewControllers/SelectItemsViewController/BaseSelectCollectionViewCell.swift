//
//  BaseCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 21/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit
import SDWebImage

class BaseSelectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
