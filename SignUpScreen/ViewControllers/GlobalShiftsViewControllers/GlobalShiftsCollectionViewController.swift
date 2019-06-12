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
    var presentationStyle = PresentationStyle.globalShift
    
    var arrayGlobalShifts: [GlobalShifts] = [GlobalShifts(name: "Clean \nenergy"), GlobalShifts(name: "Connected \nworld"), GlobalShifts(name: "Data \nowners"), GlobalShifts(name: "Demographic \nchallenges"), GlobalShifts(name: "Industry 4.0"), GlobalShifts(name: "Disruptive \nbusiness \nmodels")]
    var arrayTrends: [GlobalShifts] = [GlobalShifts(name: "Batteries\nrecycling"), GlobalShifts(name: "Clean\natmosphere"), GlobalShifts(name: "Energe\nefficiency"), GlobalShifts(name: "Recicling"), GlobalShifts(name: "Renewable\nenergy"), GlobalShifts(name: "5G"), GlobalShifts(name: "Smart\ncittles"), GlobalShifts(name: "Smart\nhome"), GlobalShifts(name: "Wearables"), GlobalShifts(name: "Big\ndata"), GlobalShifts(name: "Cloud\ncomputing"), GlobalShifts(name: "Soclal\nmedia"), GlobalShifts(name: "Ageland\npopulation"), GlobalShifts(name: "Edicational\ntechnologles"), GlobalShifts(name: "Feeding\n10B people"), GlobalShifts(name: "Obeslty"), GlobalShifts(name: "Urbanisation"), GlobalShifts(name: "Water\nscarclty"), GlobalShifts(name: "Artificlal\nintelligence"), GlobalShifts(name: "Blockchain"), GlobalShifts(name: "Get\nAmazoned")]
    var arrayIndustries: [GlobalShifts] = [GlobalShifts(name: "Energy"), GlobalShifts(name: "Materials"), GlobalShifts(name: "Indestrials"), GlobalShifts(name: "Consumer\nCyclical"), GlobalShifts(name: "Consumer\nNon-Cyclical"), GlobalShifts(name: "Healthcare"), GlobalShifts(name: "Financlals"), GlobalShifts(name: "Technology"), GlobalShifts(name: "Telecommunications"), GlobalShifts(name: "Utillities"), GlobalShifts(name: "Some"), GlobalShifts(name: "Some"), GlobalShifts(name: "Some"), GlobalShifts(name: "Some"), GlobalShifts(name: "Some")]
    var arrayCompanies: [GlobalShifts] = [GlobalShifts(name: "Amazon"), GlobalShifts(name: "Apple"), GlobalShifts(name: "Aptiv"), GlobalShifts(name: "Du"), GlobalShifts(name: "Boston Scientific")]

    override func viewDidLoad() {
        super.viewDidLoad()
        globalShiftsCollectionView.delegate = self
        globalShiftsCollectionView.dataSource = self
        
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        switch presentationStyle {
            case .globalShift:
                presentationStyle = .trends
            case .trends:
                presentationStyle = .industries
            case .industries:
                presentationStyle = .companies
            case .companies:
                break
        }
        globalShiftsCollectionView.reloadData()
        nextButton.isEnabled = false
        nextButton.backgroundColor = #colorLiteral(red: 0.9662204385, green: 0.7278981209, blue: 0.5051600337, alpha: 1)
    }
    
}

extension GlobalShiftsCollectionViewController: UICollectionViewDelegate{

}

extension GlobalShiftsCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presentationStyle {
        case .globalShift:
            arrayGlobalShifts[indexPath.row].isSelected = !arrayGlobalShifts[indexPath.row].isSelected
        case .trends:
            arrayTrends[indexPath.row].isSelected = !arrayTrends[indexPath.row].isSelected
        case .industries:
            arrayIndustries[indexPath.row].isSelected = !arrayIndustries[indexPath.row].isSelected
        case .companies:
            arrayCompanies[indexPath.row].isSelected = !arrayIndustries[indexPath.row].isSelected
        }
        
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
        switch presentationStyle {
        case .globalShift:
            return arrayGlobalShifts.count
        case .trends:
            return arrayTrends.count
        case .industries:
            return arrayIndustries.count
        case .companies:
            return arrayCompanies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if presentationStyle == .globalShift || presentationStyle == .trends || presentationStyle == .industries {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlobalShiftsCell", for: indexPath) as! GlobalShiftsCollectionViewCell
            switch presentationStyle {
                case .globalShift:
                    cell.setTitle(globalShifts: arrayGlobalShifts[indexPath.row])
                case .trends:
                    cell.setTitle(globalShifts: arrayTrends[indexPath.row])
                case .industries:
                    cell.setTitle(globalShifts: arrayIndustries[indexPath.row])
                case .companies:
                    break
            }
            return cell
        } else if presentationStyle == .companies {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompaniesCell", for: indexPath) as! CompaniesCollectionViewCell
            cell.settingCell(company: arrayCompanies[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}

extension GlobalShiftsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectoinViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth: CGFloat = 0
        var itemHeight: CGFloat = 0
        
        // Create a movable size cell corresponding to a percentage of the view size.
        switch presentationStyle{
        case .globalShift:
            itemWidth = (globalShiftsCollectionView.frame.size.width * Constants.twoItemPercenttWidth) / 2
            itemHeight = itemWidth * Constants.sixtyPercent
        case .trends:
            itemWidth = (globalShiftsCollectionView.frame.size.width * Constants.threeItemPercentWidth) / 3
            itemHeight = itemWidth * Constants.fiftyPercent
        case .industries:
            itemWidth = (globalShiftsCollectionView.frame.size.width * Constants.threeItemPercentWidth) / 3
            itemHeight = itemWidth
        case .companies:
            itemWidth = (globalShiftsCollectionView.frame.size.width * Constants.threeFotoPercetnWidth) / 3
            itemHeight = itemWidth * Constants.oneHundredFifteenPercent
        }
        
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch presentationStyle {
        case .globalShift, .companies:
            return .init(10)
        case .trends, .industries:
            return .init(5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .init(5)
    }
    
}

struct GlobalShifts {
    let name: String
    var isSelected = false
    var image: UIImage? = nil
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, image: UIImage){
        self.name = name
        self.image = image
    }
}

struct Constants {
    static let twoItemPercenttWidth: CGFloat = 0.97
    static let threeItemPercentWidth: CGFloat = 0.96
    static let threeFotoPercetnWidth: CGFloat = 0.92
    static let fiftyPercent: CGFloat = 0.5
    static let sixtyPercent: CGFloat = 0.6
    static let oneHundredFifteenPercent: CGFloat = 1.15
    
}

enum PresentationStyle {
    case globalShift
    case trends
    case industries
    case companies
}

