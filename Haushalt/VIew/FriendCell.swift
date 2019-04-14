//
//  FriendCell.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 4/14/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase

class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    
    var message: Message?
    
    func configureCell(friend: Friend) {
        friendNameLabel.text = friend.username
    }
}
