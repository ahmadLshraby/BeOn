//
//  LoginVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtn(_ sender: UIButton) {
        performSegue(withIdentifier: toCreateAccountVC, sender: nil)
    }
    
    @IBAction func logInBtn(_ sender: UIButton) {
        guard let email = emailTxt.text else { return }
        guard let password = passwordTxt.text else { return }
        AuthService.instance.logIn(email: email, password: password) { (success, error) in
            if success == true && error == nil{
                print("logged in")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    

}
