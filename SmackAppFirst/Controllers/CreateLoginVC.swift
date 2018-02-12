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
    let avatarName: String = "profileDefault"
    let avatarColor: String = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeCreateAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_UNWIND_TO_CHANNEL, sender: nil)
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
