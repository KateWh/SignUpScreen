//
//  SelectedCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SelectedCollectionConstants {
    static let reusableIdentifier = "cell"
}

class SelectedCollectionView: UICollectionView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("-------------selected-----------")
        self.delegate = self
        self.dataSource = self
    }
    
}

extension SelectedCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension SelectedCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedCollectionConstants.reusableIdentifier, for: indexPath)
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
