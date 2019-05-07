//
//  ChatVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 2/27/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SendMessageLabel: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var SendMessageView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    //Variables
    
    var messageArray : [Message] = [Message]()
    var username : String!
    var users = [User]()
    var user: User? {
        didSet {
            friendNameLabel.text = user?.username
        }
    }
    var friend: Friend?
    var friends = [Friend]()
    var selectedUser: User? {
        didSet {
            friendNameLabel.text = selectedUser?.username
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegation and data source declarations
        
        collectionView.dataSource = self
        collectionView.delegate = self
        SendMessageLabel.delegate = self
        
        // register nib
        
        collectionView.register(UINib(nibName: "SentMessageCell", bundle: nil), forCellWithReuseIdentifier: "sentMessageCell")
        
        // Aesthetic changes
        
        SendMessageLabel.layer.cornerRadius = 9.0
        SendButton.layer.cornerRadius = 9.0
        SendMessageLabel.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: SendMessageLabel.frame.height))
        SendMessageLabel.leftViewMode = .always
        
        // tap gesture recognizer
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(collectionView.endEditing(_:))))
        
        retrieveMessages()
        
        // Firebase
        
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMessageCell", for: indexPath) as! SentMessageCell
        
        cell.layer.cornerRadius = 10.0
        
        cell.MessageContentsLabel.text = messageArray[indexPath.row].messageBody
        cell.NameLabel.text = messageArray[indexPath.row].sender
        
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            self.heightConstraint.constant = 400
            self.view.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            self.heightConstraint.constant = 90
            self.view.layoutIfNeeded()
    }
    
    @IBAction func SendButtonPressed(_ sender: Any) {
        collectionView.endEditing(true)
        SendMessageLabel.isEnabled = false
        SendButton.isEnabled = false
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let toId = user!.documentId!
        let fromId = Auth.auth().currentUser!.uid
        let values = ["MessageBody": SendMessageLabel.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        let messagesDatabase = Database.database().reference().child("Messages")
        let childRef = messagesDatabase.childByAutoId()
        let messagesDictionary = ["Sender": Auth.auth().currentUser?.email,
                                  "MessageBody": SendMessageLabel.text!,
                                  ]
        childRef.updateChildValues(values)
        
        messagesDatabase.childByAutoId().setValue(messagesDictionary) {
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("Message saved successfully!")
                self.SendMessageLabel.isEnabled = true
                self.SendButton.isEnabled = true
                self.SendMessageLabel.text = ""
            }
        }
    }
    
    func retrieveMessages() {
        let messageDatabase = Database.database().reference().child("Messages")
        
        messageDatabase.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = self.username
            let message = Message()
            message.messageBody = text
            message.sender = self.username
            
            self.messageArray.append(message)
            self.collectionView.reloadData()
        }
    }
    
//    func showChatControllerForFriend(_ friend: Friend) {
//        let chatLogController = ChatVC()
//        chatLogController.friend = friend
//        navigationController?.pushViewController(chatLogController, animated: true)
//    }
}
