//
//  LoginVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/3/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func closeBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != "" else { return }
        guard let pass = passTxtField.text, passTxtField.text != "" else { return }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.userByData(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_LOGIN, sender: nil)
    }
    
    func setupView() {
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        passTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tap)
        activityIndicator.isHidden = true
    }
    
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
    
}
