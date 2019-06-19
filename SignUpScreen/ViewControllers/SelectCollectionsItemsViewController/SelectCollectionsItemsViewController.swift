//
//  SelectCollectionsItemsViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 13/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SelectCollectionsConstants {
    static let selectCollectionCellIdentifire = "selectCollectionCell"
    static let allCollectionCellIdentifire = "AllColectionCell"
    static let percentForThreeItemWidth: CGFloat = 0.91
    static let percentForVerticalSpacing: CGFloat = 0.045
}

class SelectCollectionsItemsViewController: UIViewController {
    
    @IBOutlet weak var allPicturesCollections: UICollectionView!
    @IBOutlet weak var selectPicturesCollections: UICollectionView!
    //let allPicturesCollectionView = AllPicturesCollectionView()
    //let selectPicturesCollectionView = SelectPicturesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  allPicturesCollectionView.myDelegate = selectPicturesCollectionView
    }
    
}
//
//extension SelectCollectionsItemsViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//    
//    
//    
//}
//
//extension SelectCollectionsItemsViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let _ = collectionView as? SelectPicturesCollectionView {
//            return 10
//        } else {
//            return 5
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let selectCollectionView = collectionView as? SelectPicturesCollectionView {
//            let cell = selectCollectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionsConstants.selectCollectionCellIdentifire, for: indexPath)
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionsConstants.allCollectionCellIdentifire, for: indexPath)
//            return cell
//        }
//        
//    }
//
//}
//
//extension SelectCollectionsItemsViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var itemWidth: CGFloat = 0
//        var itemHeight: CGFloat = 0
//        if let _ = collectionView as? SelectPicturesCollectionView {
//            itemHeight = collectionView.frame.height
//            itemWidth = itemHeight
//        } else {
//            itemWidth = collectionView.frame.width * SelectCollectionsConstants.percentForThreeItemWidth / 3
//            itemHeight = itemWidth
//        }
//        
//        return .init(width: itemWidth, height: itemHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let spaceWidth = collectionView.frame.width * SelectCollectionsConstants.percentForVerticalSpacing
//            return .init(spaceWidth)
//        }
//    
//}

struct ItemOfCollections {
    let image: UIImage
    let id: Int
}
