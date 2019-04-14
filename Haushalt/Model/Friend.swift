//
//  Friend.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 3/31/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import Foundation

class Friend {
    
    private(set) var username: String!
    private(set) var documentId: String!
    
    init(username: String, documentId: String) {
        self.username = username
        self.documentId = documentId
    }
}
