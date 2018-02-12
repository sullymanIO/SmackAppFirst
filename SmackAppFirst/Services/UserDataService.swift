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
}
