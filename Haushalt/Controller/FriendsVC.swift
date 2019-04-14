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
    
    var SelectedFriendId = ""
    
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
                    let newUser = Friend(username : username, documentId: documentId )
                    
                    self.friends.append(newUser)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell", for: indexPath) as? FriendCell {
            cell.layer.cornerRadius = 6
            cell.configureCell(friend: friends[indexPath.row])
            
        return cell
        }   else {
                return UICollectionViewCell()
        }
    }
    
    var chatController : ChatVC?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedFriendId = friends[indexPath.row].documentId
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatVC"{
            let destinationViewController = segue.destination as! ChatVC
            destinationViewController.SelectedFriendId = SelectedFriendId
        }
    }
    
    
}
