//
//  UserData.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/12/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()

    private(set) public var avatarColor: String = ""
    private(set) public var avatarName: String = ""
    private(set) public var email: String = ""
    private(set) public var name: String = ""
    private(set) public var id: String = ""
    
    func setUserData(id: String, name: String, email: String, avatarName: String, avatarColor: String){
        self.id = id
        self.name = name
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func logoutUser () {
        id = ""
        name = ""
        email = ""
        avatarColor = ""
        avatarName = ""
        AuthService.instance.loginStatus = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
    }
    
    func returnColor (colorString: String) -> UIColor {
//      Extracts r g b a values from db [0.454901960784314, 0.909803921568627, 0.294117647058824, 1]
        let defaultColor = UIColor.lightGray
        let scanner = Scanner(string: colorString)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a: NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rFloat = CGFloat(rUnwrapped.floatValue)
        let gFloat = CGFloat(gUnwrapped.floatValue)
        let bFloat = CGFloat(bUnwrapped.floatValue)
        let aFloat = CGFloat(aUnwrapped.floatValue)
        
        let backgroundColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return backgroundColor
    }

}
