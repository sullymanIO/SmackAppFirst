//
//  RoundedCornerBtns.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/10/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//
//
import UIKit
@IBDesignable
class RoundedCornerBtns: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        
        prepareForInterfaceBuilder()
        updateView()
    }
    
    func updateView()
    {
        self.layer.cornerRadius = cornerRadius
    }
}

