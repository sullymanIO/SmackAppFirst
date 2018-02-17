//
//  RoundedUiImages.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/15/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class RoundedUiImages: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
