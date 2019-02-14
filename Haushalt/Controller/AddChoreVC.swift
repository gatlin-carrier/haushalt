//
//  AddChoreVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 1/4/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddChoreVC: UIViewController, UITextViewDelegate {
    
    
    //Outlets
    @IBOutlet private weak var doerText: UITextField!
    @IBOutlet private weak var dueDateText: UITextField!
    @IBOutlet private weak var choreText: UITextView!
    @IBOutlet private weak var submitButton: UIButton!
    
    //Variables
    
    private var handle: AuthStateDidChangeListenerHandle?
    private var chores = [Chore]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //UI Changes
        self.choreText.layer.cornerRadius = 4
        
        choreText.text = "Add your new chore here."
        choreText.textColor = UIColor.white
        //Delegation
        choreText.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.white
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let doer = doerText.text else { return }
        guard let dueDate = dueDateText.text else { return }
        Firestore.firestore().collection("chores").addDocument(data: [
            "choreText" : choreText.text,
            "deleted" : false,
            "dueDate" : dueDate,
            "doer" : doer
        ]) { (error) in
            if let error = error {
                debugPrint("Error adding document: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    

    

}
