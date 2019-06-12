//
//  CompaniesCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 11/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class CompaniesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var tickButton: UIButton!
    
    func settingCell(company: GlobalShifts) {
        self.companyName.text = company.name
        
        if company.isSelected {
            companyName.textColor = .orange
            tickButton.isHidden = false
        } else {
            companyName.textColor = .black
            tickButton.isHidden = true
        }
    }
  
}
