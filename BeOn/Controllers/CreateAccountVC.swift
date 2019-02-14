//
//  CreateAccountVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    var avatarName = "profileDefault"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        performSegue(withIdentifier: unwindToChannel, sender: nil)
    }
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        guard let email = userEmailTxt.text else { return }
        guard let password = passwordTxt.text else { return }
        guard let name = userNameTxt.text else { return }
        

        AuthService.instance.register(name: name,email: email, password: password, avatarName: avatarName) { (success, error) in
            if success == true  && error == nil{
                print("registered")
                AuthService.instance.logIn(email: email, password: password, completion: { (success, error) in
                    if success == true && error == nil{
                        print("logged in")
                        self.performSegue(withIdentifier: unwindToChannel, sender: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarBtn(_ sender: UIButton) {
        
    }
    

    
    
    

}