//
//  CreateUserVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 12/19/18.
//  Copyright © 2018 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateUserVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func createTapped(_ sender: Any) {
        
        guard let email = emailText.text,
            let password = passwordText.text,
            let username = usernameText.text else { return }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("error creating user: \(error.localizedDescription)")
            }
            
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            })
            
            guard let userId = user?.user.uid else { return }
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME : username,
                ], completion: { (error) in
                
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
        
        
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
