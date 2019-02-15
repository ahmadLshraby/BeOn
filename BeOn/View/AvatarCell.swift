//
//  AvatarCell.swift
//  BeOn
//
//  Created by sHiKoOo on 2/15/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatrImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // To be called in collection view for item
    func configureCell(index: Int, type: AvatarType) {
        if  type == AvatarType.dark {
            avatrImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else {
            avatrImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setupView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true   // to set the image to the cutted corner radius
    }
    
}
