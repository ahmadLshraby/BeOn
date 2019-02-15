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
        
        guard let email = emailTxt.text, let password = passwordTxt.text else { return }
        
        if email.isEmpty == true || password.isEmpty == true {
            self.displayError(errorText: "Please, fill empty fields")
        }else {
            activityIndicator.isHidden = false
            
        AuthService.instance.logIn(email: email, password: password) { (success, error) in
            if success == true && error == nil{
                print("logged in")
                self.activityIndicator.isHidden = true
//                NotificationCenter.default.post(name: notifUserDataChanged, object: nil)
                self.dismiss(animated: true, completion: nil)
            }else {
                self.activityIndicator.isHidden = true
                self.displayError(errorText: "Wrong email or password")
            }
        }
    }
    }
    
    // func to display alert for any empty fields called at validation ,or wrong sign in called at press log in
    func displayError(errorText: String) {
        let alert = UIAlertController(title: "error", message: errorText, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    

}
