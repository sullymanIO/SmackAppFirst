//
//  GradientView.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/3/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2629995942, green: 0.3466132283, blue: 0.7261457443, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.3523794115, green: 0.7220543027, blue: 0.806946218, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    

}
