//
//  SocketService.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/20/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit
import SocketIO


class SocketService: NSObject {
    
    static let instance = SocketService()
    var manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    private var socket: SocketIOClient
    
    override init() {
        socket = self.manager.defaultSocket
        super.init()
        
    }
    
    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel (channelName: String, channelDes: String, completion: @escaping completionHandler) {
        socket.emit("newChannel", channelName, channelDes)
        completion(true)
    }
    
    func getChannel (completion: @escaping completionHandler) {
        socket.on("channelCreated") { (array, ack) in
            guard let name = array[0] as? String else { return }
            guard let des = array[1] as? String else { return }
            guard let id = array[2] as? String else { return }
            
            let channel = Channel(name: name, channelDes: des, id: id)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
    }
    
    func sendMessage(message: String, completion: @escaping completionHandler) {
        // client.on('newMessage', function(messageBody, userId, channelId, userName, userAvatar, userAvatarColor)
        let user = UserDataService.instance
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        socket.emit("newMessage", message, user.id, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    

}
