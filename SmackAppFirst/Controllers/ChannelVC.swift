//
//  ChannelVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/2/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profilePicImage: RoundedUiImages!
    
    @IBAction func prepareForUnwindVC(segue: UIStoryboardSegue){
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginStatus), name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @objc func loginStatus(_ userDataDidChange: Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo () {
        if AuthService.instance.loginStatus {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            profilePicImage.image = UIImage(named: UserDataService.instance.avatarName)
            profilePicImage.backgroundColor = UserDataService.instance.returnColor(colorString: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            profilePicImage.image = UIImage(named: "profileDefault")
            profilePicImage.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.loginStatus {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    
    
}

