//
//  AvatarPickerVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/12/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum avatarType {
        case dark
        case light
    }
    // Outlets
    @IBOutlet weak var avatarImgCollection: UICollectionView!
    @IBOutlet weak var segmentedBtn: UISegmentedControl!
    
    // Variables
    var avatarTypeSelected: avatarType = .dark
    
    func getAvatarType () -> String {
        if avatarTypeSelected == .dark {
            return "dark"
        } else {
            return "light"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImgCollection.delegate = self
        avatarImgCollection.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarIdentifier", for: indexPath) as? AvatarPickerCell{
            cell.configureAvatarCell(imgNumber: indexPath.row, avatarType: avatarTypeSelected)
            return cell

        } else {
            return AvatarPickerCell()
        }
        
    }
    @IBAction func sengmentedControlBtnTap(_ sender: Any) {
        if segmentedBtn.selectedSegmentIndex == 0 {
            avatarTypeSelected = .dark
        } else {
            avatarTypeSelected = .light
        }
        avatarImgCollection.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        
        let dimentiomns = (( collectionView.bounds.width - spaceBetweenCells*(numberOfColumns-1) - padding )) / numberOfColumns
        
        return CGSize(width: dimentiomns, height: dimentiomns)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if self.avatarTypeSelected == .dark {
                UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.row)")
            } else {
                UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.row)")
            }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
