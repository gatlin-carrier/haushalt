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
    var profileImageUrl: String?
    var groups: Bool?
    var friends: String?
    init(dictionary: [String: AnyObject]) {
        self.documentId = dictionary["documentId"] as? String
        self.username = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.friends = dictionary["friends"] as? String
        self.groups = dictionary["groups"] as? Bool
    }
}
