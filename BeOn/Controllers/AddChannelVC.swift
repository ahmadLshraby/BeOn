//
//  AddChannelVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/16/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createBtn(_ sender: RoundedButton) {
        guard let name = nameTxt.text, let desc = descTxt.text else { return }
        
        if name.isEmpty == true || desc.isEmpty == true {
            self.displayError(errorText: "Please, fill empty fields")
        }else {
            ChannelService.instance.addChannel(name: name) { (success) in
                if success == true {
                    
                }
            }
    }

}
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        dismiss(animated: true, completion: nil)
    }

    // func to display alert for any empty fields called at validation ,or wrong sign in called at press log in
    func displayError(errorText: String) {
        let alert = UIAlertController(title: "error", message: errorText, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
}
}
