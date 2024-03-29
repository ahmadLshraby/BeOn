//
//  CreateAccountVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Variables
    var avatarName = "profileDefault"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activityIndicator.isHidden = true
    }
    
    // Update the view from UserDataService after selecting avatar
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }else {
            userImage.image = UIImage(named: avatarName)
        }
        userImage.backgroundColor = #colorLiteral(red: 0.9221878648, green: 0.4634322524, blue: 0.001401519286, alpha: 1)
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        performSegue(withIdentifier: unwindToChannel, sender: nil)
    }
    

    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        
        guard let email = userEmailTxt.text, let password = passwordTxt.text, let name = userNameTxt.text else { return }

        if email.isEmpty == true || password.isEmpty == true || name.isEmpty == true {
            self.displayError(errorText: "Please, fill empty fields")
        }else {
            activityIndicator.isHidden = false
            
        AuthService.instance.register(name: name,email: email, password: password, avatarName: avatarName) { (success, error) in
            if success == true  && error == nil{
                print("registered")
                AuthService.instance.logIn(email: email, password: password, completion: { (success, error) in
                    if success == true && error == nil{
                        print("logged in")
                        self.activityIndicator.isHidden = true
                        // send notification to other classes that user had created and change his data to update ChannelVC
                        NotificationCenter.default.post(name: notifUserDataChanged, object: nil)
                        self.performSegue(withIdentifier: unwindToChannel, sender: nil)
                    }
                })
            }
        }
    }
    }
    // func to display alert for any empty fields , called at validation
    func displayError(errorText: String) {
        let alert = UIAlertController(title: "error", message: errorText, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func chooseAvatarBtn(_ sender: UIButton) {
        performSegue(withIdentifier: toAvatarVC, sender: nil)
        
    }
    
    func setupView() {
        
        // Change placeHolder color
        //        userNameTxt.attributedPlaceholder = NSAttributedString(string: "user name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9221878648, green: 0.4634322524, blue: 0.001401519286, alpha: 1)])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    

}
