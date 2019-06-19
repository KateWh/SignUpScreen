//
//  AllPicturesCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 18/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct AllPictureConstants {
    static let namePictures = "unnamed-3"
}

class AllPicturesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    
}
