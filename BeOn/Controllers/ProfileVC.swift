//
//  ProfileVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/15/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        AuthService.instance.signOut { (success, error) in
            if success == true && error == nil {
                // to send notification for all view that user logged out
                NotificationCenter.default.post(name: notifUserDataChanged, object: nil)
                self.dismiss(animated: true, completion: nil)
            }else {
                print(error!)
            }
        }
        
        
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = #colorLiteral(red: 0.9221878648, green: 0.4634322524, blue: 0.001401519286, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
