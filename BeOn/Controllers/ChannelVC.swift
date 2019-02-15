//
//  ChannelVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view width
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 70
        // Add observer to listen to the notification comming
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: notifUserDataChanged, object: nil)
    }
    @objc func userDataChanged() {   // to update UI depending on notification
        if AuthService.instance.isLoggedIn == true {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = #colorLiteral(red: 0.9221878648, green: 0.4634322524, blue: 0.001401519286, alpha: 1)
        }else {
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        performSegue(withIdentifier: toLoginVC, sender: nil)
    }
    


    
    
    

}
