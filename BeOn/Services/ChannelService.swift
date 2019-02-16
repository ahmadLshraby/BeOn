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
    
    
    // Add channel to Database
    func addChannel(name: String) {
        let reference = Database.database().reference()
        let channel = reference.child("Channel").childByAutoId()
        let addChannel: [String: Any] = [ "channel name": name]
        channel.setValue(addChannel) { (error, ref) in
            if error == nil {
                print(channel)
            }else {
                print(error!)
            }
        }
    }
    // Get all channel from Database
    func observeRoom() {
        let ref = Database.database().reference()
        ref.child("Channel").observe(.childAdded) { (snapshot) in
            print(snapshot)
            if let value = snapshot.value as? [String: Any] {
                print(value)
                if let name = value["channel name"] as? String {
                    let channel = ChannelData(channelName: name) // object from ChannelData
                    self.channels.append(channel)    // append to our array

                }
            }
        }
    }
}
