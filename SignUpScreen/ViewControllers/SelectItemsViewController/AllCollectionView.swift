//
//  AllCollectionView.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct AllCollectionConstants {
    static let reusableIdentifire = "allCollectionCell"
    static let percentForThreeItem: CGFloat = 0.97
    static let percentVerticalSpace: CGFloat = 0.015
    static let pointsHorizontalSpace: CGFloat = 3
    static let increment = 1
    static let decrement = -1
}

protocol SelectAllItems: class {
    func selectAll()
}

class AllCollectionView: UICollectionView {

    var getStaceAllItems: GetStateAllItems?
    var changeSelectLabel: ChangeSelectLabel?
    
    var arrayOfItems: [ImageModel] = [ImageModel(image: URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"), id: 1), ImageModel(image: URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"), id: 2), ImageModel(image: URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"), id: 3), ImageModel(image: URL(string: "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"), id: 4), ImageModel(image: URL(string: "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"), id: 5), ImageModel(image: URL(string: "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"), id: 6) ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
    
}

extension AllCollectionView: SelectAllItems {

    func selectAll() {
        if self.arrayOfItems.contains(where: { $0.isSelected == false }) {
            for index in 0..<self.arrayOfItems.count {
                self.arrayOfItems[index].isSelected = true
            }
            self.changeSelectLabel?.changeQuantity(to: self.arrayOfItems.count)
            self.reloadData()
        } else {
            for index in 0..<self.arrayOfItems.count {
                self.arrayOfItems[index].isSelected = false
            }
            self.reloadData()
        }
    }
    
}

extension AllCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.arrayOfItems[indexPath.row].isSelected {
            self.arrayOfItems[indexPath.row].isSelected = false
            self.changeSelectLabel?.changeQuantity(to: AllCollectionConstants.decrement)
        } else {
            self.arrayOfItems[indexPath.row].isSelected = true
            self.changeSelectLabel?.changeQuantity(to: AllCollectionConstants.increment)
        }
        
        if self.arrayOfItems.contains(where: { $0.isSelected == false }) {
           self.getStaceAllItems?.getState(isSelectedAll: false)
        } else {
           self.getStaceAllItems?.getState(isSelectedAll: true)
        }
        
        self.reloadItems(at: [indexPath])
    }
    
}

extension AllCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionConstants.reusableIdentifire, for: indexPath) as! AllCollectionViewCell
        cell.settingsCell(item: arrayOfItems[indexPath.row])
        cell.imageURL = arrayOfItems[indexPath.row].image
        return cell
    }

}

extension AllCollectionView: UICollectionViewDelegateFlowLayout{
    
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
