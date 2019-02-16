//
//  ChannelVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/14/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view width
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 70
        // Add observer to listen to the notification comming
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: notifUserDataChanged, object: nil)
    }
    @objc func userDataChanged() {   // to update UI depending on notification
        setupUserInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
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
        if AuthService.instance.isLoggedIn == true {   // if user is logged in it will takes him to ProfileVC
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else {
            performSegue(withIdentifier: toLoginVC, sender: nil)
        }
    }
    
    // Setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChannelService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = ChannelService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else {
            return ChannelCell()
        }
    }
    
    @IBAction func addChannel(_ sender: UIButton) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    
    
    
    
    
}
