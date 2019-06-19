//
//  SelectPicturesCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 18/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SelectCollectionsConstants {
    static let selectCollectionCellIdentifire = "selectCollectionCell"
}

class SelectPicturesCollectionView: UICollectionView {

    var arraySelectItem: [ItemOfCollections] = []
    override func awakeFromNib() {

    }

}

extension SelectPicturesCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

extension SelectPicturesCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySelectItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionsConstants.selectCollectionCellIdentifire, for: indexPath)
        return cell
    }
    
}

extension SelectPicturesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.frame.height
        let itemWidth = itemHeight
        
        return .init(width: itemWidth, height: itemHeight)
    }

}

extension SelectPicturesCollectionView: SelectPictures {
    
    func addPicturesToSelectArray(item: ItemOfCollections) {
        print("Ура!!!!!!!!!!!!!!!!!!!")
        self.arraySelectItem.append(item)
        self.reloadData()
    }
    
    
    
}
