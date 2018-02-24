//
//  ProfileVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/17/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // Outlets
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!

    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tappedOnBg))
        view.addGestureRecognizer(tap)
    }
    @objc func tappedOnBg(_: UIGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    func setupView() {
        profileimg.image = UIImage(named: UserDataService.instance.avatarName)
        profileimg.backgroundColor = UIColor(named: UserDataService.instance.avatarColor)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileimg.backgroundColor = UserDataService.instance.returnColor(colorString: UserDataService.instance.avatarColor)
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.post(name: TO_NOTIFY_CHANNELS_UPLOADED, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
