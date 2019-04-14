//
//  LoginVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 11/16/18.
//  Copyright © 2018 Gatlin Carrier. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Actions
    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = emailText.text,
            let password = passwordText.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

