//
//  SelectImageViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

struct ImageModel {
    let image: URL?
    let id: Int
    var isSelected = false
    
    init(image: URL?, id: Int){
        self.image = image
        self.id = id
    }
}

class SelectImageViewController: UIViewController {
    
    @IBOutlet weak var selectedCollectionView: SelectedCollectionView!
    @IBOutlet weak var allCollectionView: AllCollectionView!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    weak var inputDelegate: InputProtocol?
    weak var giveAllDelegate: GiveAllItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allCollectionView.outputDelegate = self
        self.inputDelegate = selectedCollectionView
        self.giveAllDelegate = allCollectionView

    }
    
    @IBAction func tapSelectAllButton(_ sender: UIButton) {
        guard let items = self.giveAllDelegate?.giveItems() else { return }
        self.inputDelegate?.getAllItems(items: items )
        self.checkMarkButton.isSelected = !self.checkMarkButton.isSelected
        
    }
    
}

extension SelectImageViewController: OutputProtocol {
    
    func setItem(item: ImageModel, selectAll: Bool) {
        self.inputDelegate?.getItem(item: item)
        if selectAll {
            self.checkMarkButton.isSelected = selectAll
        }
    }
    
    func deleteItem(byId id: Int) {
        self.inputDelegate?.deleteItem(byId: id)
        if self.checkMarkButton.isSelected {
            self.checkMarkButton.isSelected = false
        }
    }
    
}
