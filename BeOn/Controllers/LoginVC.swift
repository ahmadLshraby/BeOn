//
//  LoginVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtn(_ sender: UIButton) {
        performSegue(withIdentifier: toCreateAccountVC, sender: nil)
    }
    
    @IBAction func logInBtn(_ sender: UIButton) {
        
        activityIndicator.isHidden = false
        
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        
        AuthService.instance.logIn(email: email, password: password) { (success, error) in
            if success == true && error == nil{
                print("logged in")
                NotificationCenter.default.post(name: notifUserDataChanged, object: nil)
                self.activityIndicator.isHidden = true
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    

}
