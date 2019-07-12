//
//  ConsAndProsViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 11/07/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

struct ConsAndProsConstans {
    static let orange = #colorLiteral(red: 0.928688705, green: 0.4449062943, blue: 0.01238056459, alpha: 1)
    static let violet = #colorLiteral(red: 0.1641466022, green: 0.1814783216, blue: 0.2983416915, alpha: 1)
    static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let onePointers: CGFloat = 1
    static let twoPointers: CGFloat = 2
    static let disagreeButtonText = "12847\nusers"
    static let agreeButtonText = "2839\nusers"
}

class ConsAndProsViewController: UIViewController {
    
    @IBOutlet weak var disagreeLabel: UILabel!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var disagreeButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupButton()
    }
    
    
    @IBAction func tapDisagreeButton(_ sender: UIButton) {
        self.disagreeButton.isEnabled = false
        self.disagreeButton.setTitle(BaseConstants.emptyString, for: .normal)
        self.disagreeButton.backgroundColor = ConsAndProsConstans.violet
        self.disagreeLabel.textColor = ConsAndProsConstans.white
        self.disagreeLabel.text = ConsAndProsConstans.disagreeButtonText
        self.minusButton.backgroundColor = ConsAndProsConstans.white
        self.minusButton.setTitleColor(ConsAndProsConstans.violet, for: .normal)
        self.minusButton.isHidden = false
        
        self.agreeButton.isEnabled = false
        self.agreeButton.setTitle(BaseConstants.emptyString, for: .normal)
        self.agreeLabel.text = ConsAndProsConstans.agreeButtonText
        self.plusButton.backgroundColor = ConsAndProsConstans.orange
        self.plusButton.setTitleColor(ConsAndProsConstans.white, for: .normal)
        self.plusButton.isHidden = false
    }
    
    @IBAction func tapAgreeButton(_ sender: UIButton) {
        self.disagreeButton.isEnabled = false
        self.disagreeButton.setTitle(BaseConstants.emptyString, for: .normal)
        self.disagreeLabel.text = ConsAndProsConstans.disagreeButtonText
        self.minusButton.backgroundColor = ConsAndProsConstans.violet
        self.minusButton.setTitleColor(ConsAndProsConstans.white, for: .normal)
        self.minusButton.isHidden = false
        
        self.agreeButton.isEnabled = false
        self.agreeButton.setTitle(BaseConstants.emptyString, for: .normal)
        self.agreeButton.backgroundColor = ConsAndProsConstans.orange
        self.agreeLabel.textColor = ConsAndProsConstans.white
        self.agreeLabel.text = ConsAndProsConstans.agreeButtonText
        self.plusButton.setTitleColor(ConsAndProsConstans.orange, for: .normal)
        self.plusButton.isHidden = false
    }
    

    func setupButton() {
        self.disagreeButton.layer.cornerRadius = self.disagreeButton.frame.height / ConsAndProsConstans.twoPointers
        self.disagreeButton.layer.borderColor = ConsAndProsConstans.violet.cgColor
        self.minusButton.layer.cornerRadius = self.minusButton.frame.height / ConsAndProsConstans.twoPointers
        
        self.agreeButton.layer.cornerRadius = self.disagreeButton.frame.height / ConsAndProsConstans.twoPointers
        self.agreeButton.layer.borderColor = ConsAndProsConstans.orange.cgColor
        self.plusButton.layer.cornerRadius = self.plusButton.frame.height / ConsAndProsConstans.twoPointers
    }
    
    
}
