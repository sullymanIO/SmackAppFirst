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
let TO_PICK_AVATAR = "pickAvatar"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Placeholder color
let PLACEHOLDER_COLOR: UIColor = #colorLiteral(red: 0.5157704353, green: 0.04799040407, blue: 1, alpha: 0.5)

// Notifications
let TO_NOTIFY_USER_DATA_CHANGED = Notification.Name("notifyUserDataChanged")
let TO_NOTIFY_CHANNELS_UPLOADED = Notification.Name("channelsUploaded")
let TO_NOTIFY_CHANNEL_NAME_CHANGED = Notification.Name("channelNameChanged")

//  Handlers
typealias completionHandler = (_ Success: Bool) -> ()

let BASE_URL = "https://smackappfirst.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_USER_URL = "\(BASE_URL)user/add"
let FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let FIND_ALL_CHANNELS = "\(BASE_URL)channel"
let CREATE_CHANNEL_URL = "\(BASE_URL)channel/add"
let GET_MESSAGE_BY_CHANNEL_URL = "\(BASE_URL)message/byChannel/"


// Headers
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

