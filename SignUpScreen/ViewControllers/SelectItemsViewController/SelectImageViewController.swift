//
//  SelectImageViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

struct SelectImageConstants {
    static let selectText = "SELECT"
    static let openHooks = "("
    static let closeHooks = ")"
    static let orange = #colorLiteral(red: 0.9286673665, green: 0.4298341274, blue: 0, alpha: 1)
    static let lightOrange = #colorLiteral(red: 0.9583123326, green: 0.7007719874, blue: 0.4598380327, alpha: 1)
}

struct ImageModel {
    let image: URL?
    let id: Int
    var isSelected = false
    
    init(image: URL?, id: Int){
        self.image = image
        self.id = id
    }
}

protocol ChangeSelectLabel {
    func changeQuantity(to: Int)
}

protocol GetStateAllItems {
    func getState(isSelectedAll: Bool)
}

class SelectImageViewController: UIViewController {
    
    @IBOutlet weak var allCollectionView: AllCollectionView!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    
    
    weak var selectAllDelegate: SelectAllItems?
    var countSelectItems = 0 {
        didSet {
            if self.countSelectItems > 0 {
                selectButton.title = SelectImageConstants.selectText + SelectImageConstants.openHooks +  String(self.countSelectItems) + SelectImageConstants.closeHooks
                self.deleteButton.isEnabled = true
                self.deleteButton.setTitleColor(SelectImageConstants.orange, for: .normal)
                self.moveButton.isEnabled = true
                self.moveButton.setTitleColor(SelectImageConstants.orange, for: .normal)
            } else {
                selectButton.title = SelectImageConstants.selectText
                self.deleteButton.isEnabled = false
                self.deleteButton.setTitleColor(SelectImageConstants.lightOrange, for: .normal)
                self.moveButton.isEnabled = false
                self.moveButton.setTitleColor(SelectImageConstants.lightOrange, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectAllDelegate = allCollectionView
        self.allCollectionView.getStaceAllItems = self
        self.allCollectionView.changeSelectLabel = self
    }
    
    @IBAction func tapSelectAllButton(_ sender: UIButton) {
        self.countSelectItems = 0
        self.selectAllDelegate?.selectAll()
        self.checkMarkButton.isSelected = !self.checkMarkButton.isSelected
    }
    
}

extension SelectImageViewController: ChangeSelectLabel {
    func changeQuantity(to quantity: Int) {
        self.countSelectItems += quantity
    }
}

extension SelectImageViewController: GetStateAllItems {
    func getState(isSelectedAll: Bool) {
        self.checkMarkButton.isSelected = isSelectedAll
    }
}
