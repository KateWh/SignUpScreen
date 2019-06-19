//
//  AllPicturesCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 18/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct AllCollectionsConstants {
    static let namePictures = "unnamed-3"
    static let allCollectionCellIdentifire = "allColectionCell"
    static let percentForThreeItemWidth: CGFloat = 0.91
    static let percentForVerticalSpacing: CGFloat = 0.045
}

protocol SelectPictures: class {
    func addPicturesToSelectArray(item: ItemOfCollections)
}

class AllPicturesCollectionView: UICollectionView {

      let arrayAllItem = [ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 1), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 2), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 3), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 4), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 5), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 6), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 7), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 8), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 9), ItemOfCollections(image: UIImage(named: AllCollectionsConstants.namePictures)!, id: 10) ]
    weak var myDelegate: SelectPictures? 
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
    }
    
    
  
}

extension AllPicturesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Bingo", myDelegate)
        myDelegate?.addPicturesToSelectArray(item: arrayAllItem[indexPath.row])
    }
    
}

extension AllPicturesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayAllItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionsConstants.allCollectionCellIdentifire, for: indexPath) as! AllPicturesCollectionViewCell
        return cell
    }

}

extension AllPicturesCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * AllCollectionsConstants.percentForThreeItemWidth / 3
        let itemHeight = itemWidth
        
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spaceWidth = collectionView.frame.width * AllCollectionsConstants.percentForVerticalSpacing
        return .init(spaceWidth)
    }
    
}

