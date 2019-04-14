//
//  User.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 3/25/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit

class User: NSObject {
    var documentId: String?
    var username: String?
    var email: String?
    var groups: Bool?
    var friends: Bool?
    
    init(username: String, documentId: String, email: String, groups: Bool, friends: Bool) {
        self.username = username
        self.documentId = documentId
        self.email = email
        self.groups = groups
        self.friends = friends
    }
}
