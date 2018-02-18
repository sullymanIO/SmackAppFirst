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
    
    var channels = [Channel]()
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
                    completion(true)
                }
                    
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
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
    }



