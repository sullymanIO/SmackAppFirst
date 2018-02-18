//
//  ChatVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/2/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {


    @IBOutlet weak var revealBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.loginStatus {
            AuthService.instance.userByData(completion: { (success) in
                if success {
                    MessageService.instance.getChannels(completion: { (success) in
                        if success {
                            print(MessageService.instance.channels)
                        }
                        
                    })
                    NotificationCenter.default.post(name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
                }
            })
        }
    
    }

}
