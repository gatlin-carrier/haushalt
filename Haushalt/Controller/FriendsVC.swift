//
//  FriendsVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 3/13/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase


class FriendsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friends = [Friend]()
    var chats = [Chats]()
    var users = [User]()
    
    var selectedUser: User?
    
    private var usersCollectionRef : CollectionReference!
    private var CollectionRef : CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        usersCollectionRef = Firestore.firestore().collection("users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usersCollectionRef.getDocuments{ ( snapshot, error ) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }
            else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let username = data["username"] as? String ?? ""
                    let documentId = document.documentID
                    let email = data["email"] as? String ?? ""
                    let groups = data["groups"] as? Bool ?? false
                    let friends = data["friends"] as? Bool ?? false
                    let newUser = User(username: username, documentId: documentId, email: email, groups: groups, friends: friends)
                    
                    self.users.append(newUser)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCell {
            cell.layer.cornerRadius = 6
            cell.configureCell(user: users[indexPath.row])
            
        return cell
        }   else {
                return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
    }
    
    var chatController : ChatVC?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatVCSegueIdentifier"{
            if let collectionCell: UserCell = sender as? UserCell {
                if let collectionView: UICollectionView = collectionCell.superview as? UICollectionView {
                    if let destinationViewController = segue.destination as? ChatVC {
                        destinationViewController.selectedUser = users[collectionView.tag]
                        destinationViewController.selectedUser = selectedUser
                    }
                }
            }
        }
    }
    
    
}
