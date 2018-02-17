//
//  CreateLoginVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/3/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class CreateLoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var pickAvatarBtn: UIButton!
    
    // Variables
    var avatarName: String = "profileDefault"
    var avatarColor: String = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            profileImageView.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        if bgColor == nil && avatarName.contains("light") {
            profileImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
    }
    
    @IBAction func generateColorBtnPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.3) {
            self.profileImageView.backgroundColor = self.bgColor
        }
        
    }
    @IBAction func pickAvatarBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_PICK_AVATAR, sender: nil)
    }
    
    @IBAction func closeCreateAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_UNWIND_TO_CHANNEL, sender: nil)
    }
    
    
    func setupView() {
        userNameTxtField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text , emailTxtField.text != "" else {
            return
        }
        guard let password = passwordTxtField.text , passwordTxtField.text != "" else {
            return
        }
        guard let userName = userNameTxtField.text , userNameTxtField.text != "" else {
            return
        }
        
        func setProfileAvatar (imageName: String)
        {
            profileImageView.image = UIImage (named: imageName)
            avatarName = imageName
        }

        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        activityIndicator.startAnimating()
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered User!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("logged in user!", AuthService.instance.authToken)
                        AuthService.instance.addUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("User Added!")
                                activityIndicator.stopAnimating() // On response stop animating
                                activityIndicator.removeFromSuperview() // remove the view
                                
                                self.performSegue(withIdentifier: TO_UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
                            } else {
                                print("Failed to add user")
                                activityIndicator.stopAnimating()
                                activityIndicator.removeFromSuperview()
                            }
                        })
                    } else {
                        print("Failed to Register")
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                    }
                })
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                print("failed")
            }
        }
    }
    

}
