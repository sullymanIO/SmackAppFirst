//
//  Channel.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/18/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation

struct Channel {
    
    private(set) public var channel: String?
    private(set) public var channelDescription: String?
    private(set) public var id: String?
    
    init(name: String, channelDes: String, id: String) {
        channel = name
        channelDescription = channelDes
        self.id = id
    }
}
