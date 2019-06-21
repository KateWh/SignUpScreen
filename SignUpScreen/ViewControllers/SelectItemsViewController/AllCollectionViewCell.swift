//
//  AllCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class AllCollectionViewCell: BaseSelectCollectionViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    
    func settingsCell(item: ImageModel)
    {
        self.checkboxButton.isHidden = !item.isSelected
    }
    
}
