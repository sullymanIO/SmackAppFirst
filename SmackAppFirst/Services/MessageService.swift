//
//  MessageService.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/18/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    // Variables
    var channels = [Channel]()
    var messages = [Message]()
    private(set) public var selectedChannel: Channel?
    // var chnDec = [DecoderWayOfDoingChannels]()
    func getChannels (completion: @escaping completionHandler) {
        Alamofire.request(FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data).array{
                    for items in json {
                        let name = items["name"].stringValue
                        let channelDes = items["description"].stringValue
                        let id = items["_id"].stringValue
                        let channel = Channel(name: name, channelDes: channelDes, id: id)
                        self.channels.append(channel)
                    }
                    
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            }
        }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping completionHandler) {
//    {
//        "name": "random",
//        "description": "this is the random channel, talk about whatevs!"
//        }
        let body = [
            "name": channelName,
            "description": channelDescription
        ]
        Alamofire.request(CREATE_CHANNEL_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.result.error == nil {
                print("channel saved successfully")
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion (false)
            }
        }
    }
    
    func clearChannels() {
        self.channels = []
        selectedChannel = nil
    }
    
    func updateChannelName(channel: Channel) {
        selectedChannel = channel
    }
    
    func getAllMessages (completion: @escaping completionHandler) {
        guard let channelId = selectedChannel?.id else { return }
        Alamofire.request("\(GET_MESSAGE_BY_CHANNEL_URL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let completeJson = JSON(data).array {
                    for json in completeJson {
                        let id = json["_id"].stringValue
                        let messageBody = json["messageBody"].stringValue
                        let userId = json["userId"].stringValue
                        let channelId = json["channelId"].stringValue
                        let userName = json["userName"].stringValue
                        let userAvatar = json["userAvatar"].stringValue
                        let userAvatarColor = json["userAvatarColor"].stringValue
                        let timeStamp = json["timeStamp"].stringValue
                        let message = Message(id: id, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                }
                
                completion(true)
            } else {
                completion(false)
        }

            }
        }
    }

//   this function is the latest way of decoding json
//    func doItWithDecoder (completion: @escaping completionHandler) {
//
//        Alamofire.request(FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
//
//            if response.result.error == nil {
//                guard let data = response.data else { return }
//                do {
//                   self.chnDec  = try JSONDecoder().decode([DecoderWayOfDoingChannels].self, from: data)
//                } catch let error {
//                    print(error as Any)
//                }
//                    print(self.chnDec)
//                    completion(true)
//                }
//
//            }
//
//        }




