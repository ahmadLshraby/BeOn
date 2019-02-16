//
//  ChannelService.swift
//  BeOn
//
//  Created by sHiKoOo on 2/16/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import Firebase

class ChannelService {
    static let instance = ChannelService()
    var channels = [ChannelData]()   // empty array from ChannelData model to fill in with data
    
    // Create reference from Database
    let reference = Database.database().reference()
    
    // Add channel to Database
    func addChannel(name: String, completion: @escaping(_ success: Bool) -> Void) {
        let channel = reference.child("Channel").childByAutoId()
        let addChannel: [String: Any] = [ "channel name": name]
        channel.setValue(addChannel) { (error, ref) in
            if error == nil {
                
            }
        }
    }
    // Get all channel from Database
    func observeRoom() {
        reference.child("Channel").observe(.value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                if let name = value["channel name"] as? String {
                    let channel = ChannelData(channelName: name)   // object from ChannelData
                    self.channels.append(channel)    // append to our array
                }
            }
        }
    }
}
