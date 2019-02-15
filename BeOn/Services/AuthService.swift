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

    func register(name: String, email: String, password: String, avatarName: String, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                UserDataService.instance.setUserData(name: name, email: email, avatarName: avatarName)
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
                
                
                let ref = Database.database().reference()
                let userID = Auth.auth().currentUser?.uid
                ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    print(value)
                    let name = value?["user name"] as? String ?? ""
                    let avatar = value?["avatar name"] as? String ?? ""
                    UserDataService.instance.setUserData(name: name, email: email, avatarName: avatar)
                    // after we get the data from database and set it to app we send notification
                    NotificationCenter.default.post(name: notifUserDataChanged, object: nil)
                    print(name, avatar)
                    
                })

               self.isLoggedIn = true
                completion(true, nil)
            }else {
                completion(false, error)
            }
        })
    }
    
    func signOut(completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        self.isLoggedIn = false
        do {
            try Auth.auth().signOut()
//            UserDataService.instance.setUserData(name: "", email: "", avatarName: "")
            completion(true, nil)
        }catch {
            print(error)
            completion(false, error)
        }
    }
    

    

    
    
    
}
