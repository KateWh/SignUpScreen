//
//  GlobalShiftsCollectionViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 10/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class GlobalShiftsCollectionViewController: UIViewController {

    @IBOutlet weak var globalShiftsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var arrayGlobalShifts: [GlobalShifts] = [GlobalShifts(name: "Clean \nenergy"), GlobalShifts(name: "Connected \nworld"), GlobalShifts(name: "Data \nowners"), GlobalShifts(name: "Demographic \nchallenges"), GlobalShifts(name: "Industry 4.0"), GlobalShifts(name: "Disruptive /nbusiness /nmodels")]

    override func viewDidLoad() {
        super.viewDidLoad()
        globalShiftsCollectionView.delegate = self
        globalShiftsCollectionView.dataSource = self
        globalShiftsCollectionView.collectionViewLayout = UICollectionViewLayout()
    }
   
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        
    }
    
}

extension GlobalShiftsCollectionViewController: UICollectionViewDelegate{
    
}

extension GlobalShiftsCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Нажатие")
        arrayGlobalShifts[indexPath.row].isSelected = !arrayGlobalShifts[indexPath.row].isSelected
        collectionView.reloadItems(at: [indexPath])
        
        for element in arrayGlobalShifts {
            if element.isSelected {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .orange
                return
            }
        }
        
        nextButton.isEnabled = false
        nextButton.backgroundColor = #colorLiteral(red: 0.9662204385, green: 0.7278981209, blue: 0.5051600337, alpha: 1)
    }
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGlobalShifts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlobalShiftsCell", for: indexPath) as! GlobalShiftsCollectionViewCell
        cell.setTitle(globalShifts: arrayGlobalShifts[indexPath.row])
        return cell
    }
    
}

extension GlobalShiftsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
}


struct GlobalShifts {
    let name: String
    var isSelected = false
    var image: UIImage? = nil
    
    init(name: String) {
        self.name = name
    }
}

enum presentationStyle {
    case globalShift
    case trends
    case undestries
    case companies
}
