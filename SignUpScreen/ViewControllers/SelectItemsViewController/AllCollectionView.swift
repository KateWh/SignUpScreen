//
//  AllCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct AllCollectionConstants {
    static let reusableIdentifire = "cell"
    static let percentForThreeItem: CGFloat = 0.97
    static let percentVerticalSpace: CGFloat = 0.015
    static let pointsHorizontalSpace: CGFloat = 3
}

class AllCollectionView: UICollectionView {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        print("-------------all------------")
        self.delegate = self
        self.dataSource = self
    }
    
}

extension AllCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Нажатие..")
    }
    
}

extension AllCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionConstants.reusableIdentifire, for: indexPath) as! AllCollectionViewCell 
        return cell
    }

}

extension AllCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * AllCollectionConstants.percentForThreeItem / 3
        let itemHeight = itemWidth
        
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .init(AllCollectionConstants.pointsHorizontalSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spaceWidth = collectionView.frame.width * AllCollectionConstants.percentVerticalSpace

        return .init(spaceWidth)
    }
    
}
