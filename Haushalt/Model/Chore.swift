//
//  Chore.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 12/23/18.
//  Copyright © 2018 Gatlin Carrier. All rights reserved.
//

import Foundation

class Chore {
    
    private(set) var username: String!
    private(set) var choreText: String!
    private(set) var dueDate: String!
    private(set) var deleted: Bool!
    private(set) var documentId: String!
    private(set) var doer: String!
    
    init(username: String, choreText: String, dueDate: String, deleted: Bool, documentId: String, doer: String) {
        
        self.username = username
        self.choreText = choreText
        self.dueDate = dueDate
        self.deleted = deleted
        self.documentId = documentId
        self.doer = doer
    }
}
