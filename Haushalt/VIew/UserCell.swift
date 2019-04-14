//
//  UserCell.swift
//  
//
//  Created by Gatlin Carrier on 4/14/19.
//

import UIKit
import Firebase

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    var message: Message?
    
    func configureCell(user: User) {
        userNameLabel.text = user.username
    }
}
