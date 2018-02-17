//
//  AvatarPickerCellCollectionViewCell.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/12/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class AvatarPickerCell: UICollectionViewCell {
    // Outlets
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    // For rounded corners of collection view cells
    func setupView() {
        self.layer.cornerRadius = 10.0
    }
    // Sets up the avatar image and background
    func configureAvatarCell(imgNumber: Int, avatarType: AvatarPickerVC.avatarType){
        if avatarType == .dark {
            avatarImg.image = UIImage(named: "dark\(imgNumber)")
            self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            avatarImg.image = UIImage(named: "light\(imgNumber)")
            self.layer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
    }
}
