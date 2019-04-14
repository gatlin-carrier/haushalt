//
//  AuthService.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 12/17/18.
//  Copyright © 2018 Gatlin Carrier. All rights reserved.
//
import Foundation
import Firebase

func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping ( _ status: Bool, _ error: Error?) -> ()) {
    Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
        guard let authData = authData?.user else {
            userCreationComplete(false, error)
            
            return
        }
        
        let userData = ["provider": authData.providerID, "email": authData.email]
        DataService.instance.createDBUser(uid: authData.uid, userData: userData as Dictionary<String, Any>)
        userCreationComplete(true, nil)
    }
}

func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping ( _ status: Bool, _ error: Error?) -> ()) {
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if error != nil {
            loginComplete(false, error)
            return
        }
        loginComplete(true, nil)
    }
}

