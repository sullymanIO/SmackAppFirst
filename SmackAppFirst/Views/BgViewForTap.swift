//
//  BgViewForTap.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/17/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class BgViewForTap: UIView {
    @IBOutlet weak var bgViewTap: UIView!
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tappedOnBg))
    
    
    
}
