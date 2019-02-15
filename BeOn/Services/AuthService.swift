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
            return defaults.value(forKey: PASSWORD) as! String
        }
        set {
            defaults.set(newValue, forKey: PASSWORD)
        }
    }
    var name: String {
        get {
            return defaults.value(forKey: NAME) as! String
        }
        set {
            defaults.set(newValue, forKey: NAME)
        }
    }
    var avatarName: String {
        get {
            return defaults.value(forKey: AVATAR_NAME) as! String
        }
        set {
            defaults.set(newValue, forKey: AVATAR_NAME)
        }
    }
    
    
    func register(name: String, email: String, password: String, avatarName: String, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        UserDataService.instance.setUserData(name: name, email: email, avatarName: avatarName)
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                // get the id for the created user
                guard let userId = result?.user.uid else { return }
                // Create reference from Database
                let reference = Database.database().reference()
                // Create child in Database
                let user = reference.child("Users").child(userId)
                // Create array for the additional data we need to add to Database
                let addData: [ String: Any] = [ "user name": name, "avatar name": avatarName]
                // Add that data to the child we created in Database
                user.setValue(addData)
                completion(true, nil)
            }else {
                completion(false, error)
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
            if error == nil {
                self.userEmail = email
                self.password = password
                self.name = UserDataService.instance.name
                self.avatarName = UserDataService.instance.avatarName
                self.isLoggedIn = true
                completion(true, nil)
            }else {
                completion(false, error)
            }
        })
    }
    
    func signOut(completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.userEmail = ""
            self.password = ""
            completion(true, nil)
        }catch {
            print(error)
            completion(false, error)
        }
    }
    

    
    
    
}
