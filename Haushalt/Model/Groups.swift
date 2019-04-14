//
//  Groups.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 4/7/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import Foundation

class Group: NSObject {
    var groupName: String?
    var members: String?
    var chores: String?
    var choreId: String?
    var chatId: String?
    init(dictionary: [String: AnyObject]) {
        self.groupName = dictionary["groupName"] as? String
        self.members = dictionary["members"] as? String
        self.chores = dictionary["chores"] as? String
        self.chatId = dictionary["chatId"] as? String
        self.choreId = dictionary["choreId"] as? String

    }
}
