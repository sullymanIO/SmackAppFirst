//
//  message.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/23/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation

struct Message {
    private(set) public var id: String?
    private(set) public var messageBody: String?
    private(set) public var userId: String?
    private(set) public var channelId: String?
    private(set) public var userName: String?
    private(set) public var userAvatar: String?
    private(set) public var userAvatarColor: String?
    private(set) public var timeStamp: String?
    
    init(id: String, messageBody: String, userId: String, channelId: String, userName: String, userAvatar: String, userAvatarColor: String, timeStamp: String) {
        self.id = id
        self.messageBody = messageBody
        self.userId = userId
        self.channelId = channelId
        self.userName = userName
        self.userAvatar = userAvatar
        self.userAvatarColor = userAvatarColor
        self.timeStamp = timeStamp
    }
}
