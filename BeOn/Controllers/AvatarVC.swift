//
//  AvatarVC.swift
//  BeOn
//
//  Created by sHiKoOo on 2/15/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentBtn(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            avatarType = .dark
        }else {
            avatarType = .light
        }
        collectionView.reloadData()   // to reload the data again after choose from segment
    }
    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }else {
        return AvatarCell()
        }
    }
    
    // When select item set the avatarName property in UserData by calling the setAvatarName func
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // To set the columns of collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {    // 320 is the screen width for the smallest iPhone
            numberOfColumns = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40   // distance between collection view edge and screen
        let cellDimension = (( collectionView.bounds.width - padding) - ( numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns   // (collectionView width - padding) - (space between cells * its numbers) / number of columns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    


    
    

}
