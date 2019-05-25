//
//  User.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 3/25/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var username: String?
    var email: String?
    var groups: Bool?
    var friends: Bool?
    var id: String?
    
    init(username: String, documentId: String, email: String, groups: Bool, friends: Bool, id: String) {
        self.username = username
        self.email = email
        self.groups = groups
        self.friends = friends
        self.id = id
    }
}
