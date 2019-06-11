//
//  GlobalShiftsCollectionViewCell.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 10/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class GlobalShiftsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var globalShiftTitle: UILabel!
    @IBOutlet weak var tickButton: UIButton!
    
    func setTitle(globalShifts: GlobalShifts) {
        globalShiftTitle.text = globalShifts.name
        
        if globalShifts.isSelected {
            globalShiftTitle.textColor = .orange
            tickButton.isHidden = false
        } else {
            globalShiftTitle.textColor = .black
            tickButton.isHidden = true
        }
        
    }
  
}
