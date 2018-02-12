//
//  Constants.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/3/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation
// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_LOGIN = "createLogin"
let TO_UNWIND_TO_CHANNEL = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//  Handlers
typealias completionHandler = (_ Success: Bool) -> ()

let BASE_URL = "https://smackappfirst.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_USER_URL = "\(BASE_URL)user/add"

