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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view width
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 70
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        performSegue(withIdentifier: toLoginVC, sender: nil)
    }
    


    
    
    

}
