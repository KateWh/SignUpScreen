//
//  SelectedCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SelectedCollectionConstants {
    static let reusableIdentifier = "selectedCollectionCell"
}

protocol InputProtocol: class {
    func getItem(item: ImageModel)
    func deleteItem(byId: Int)
    func getAllItems(items: [ImageModel])
}

class SelectedCollectionView: UICollectionView {

    var arrayOfItem: [ImageModel] = []
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
    
}

extension SelectedCollectionView: InputProtocol {
   
    func getItem(item: ImageModel) {
        arrayOfItem.append(item)
        self.reloadData()
    }
    
    func deleteItem(byId id: Int) {
        arrayOfItem.removeAll { $0.id == id }
        self.reloadData()
    }
    
    func getAllItems(items: [ImageModel]) {
        arrayOfItem.removeAll()
        arrayOfItem.append(contentsOf: items)
        self.reloadData()
    }
    
}

extension SelectedCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedCollectionConstants.reusableIdentifier, for: indexPath) as! SelectedCollectionViewCell
        cell.imageURL = arrayOfItem[indexPath.row].image
        return cell
    }
    
}

extension SelectedCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.frame.height
        let itemWidth = itemHeight
        
        return .init(width: itemWidth, height: itemHeight)
    }
    
}
