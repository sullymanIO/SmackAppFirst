//
//  File.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/6/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    
    var loginStatus: Bool {
         get {
            return self.defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser (email: String, password: Any, completion: @escaping completionHandler){
        let lowercaseEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        let body: [String: Any] = [
            "email": lowercaseEmail,
            "password": password
        ]
        print(header)
        print(body)
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error ?? "error")
            }
        }
    
    }
    
    func loginUser (email: String, password: Any, completion: @escaping completionHandler)
    {
        let lowercaseEmail = email.lowercased()
        let header = ["Content-Type": "application/json; charset=utf-8"]
        let body: [String: Any] = ["email": lowercaseEmail, "password": password ]
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
           if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String, Any>
//                {
//                    if let email = json["user"] as? String{
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String{
//                        self.authToken = token
//                        print(token)
//                    }
//                    completion(true)
//                }
            
            // SwiftyJSON
            guard let data = response.data else { return }
            let json = JSON(data)
            self.userEmail = json["user"].stringValue
            self.authToken = json["token"].stringValue
 
            self.loginStatus = true
            completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
                
                
            }
        }
    }
    
    func addUser (name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping completionHandler){
        
        let lowercaseEmail = email.lowercased()
        let header = [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        let body = [
            "name": name,
            "email": lowercaseEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        
        Alamofire.request(ADD_USER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else { return }
                let json = JSON(data)
                let id = json["_id"].stringValue
                let name = json["name"].stringValue
                let email = json["email"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
                print(id, name, email, avatarName, avatarColor)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
}
