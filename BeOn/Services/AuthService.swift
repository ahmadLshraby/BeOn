//
//  AuthService.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: loggedInKey)
        }
        set {
            defaults.set(newValue, forKey: loggedInKey)
        }
    }
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    var password: String {
        get {
            return defaults.value(forKey: pass) as! String
        }
        set {
            defaults.set(newValue, forKey: pass)
        }
    }
    
    
    func register(name: String, email: String, password: String, avatarName: String, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                completion(true, nil)
            }else {
                completion(false, error)
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.userEmail = email
                self.isLoggedIn = true
                completion(true, nil)
            }else {
                completion(false, error)
            }
        })
    }

    
    
    
    
    
    
}
