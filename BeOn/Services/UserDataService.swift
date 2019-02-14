//
//  UserDataService.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    
    func setUserData(name: String, email: String, avatarName: String) {
        self.name = name
        self.email = email
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
