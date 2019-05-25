//
//  FriendsVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 3/13/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase


class FriendsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!

    
    var friends = [Friend]()
    var chats = [Chats]()
    var users = [User]()
    var selectedUser: User?
    var user: User?
    var usersCollectionRef : CollectionReference!
    var CollectionRef : CollectionReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
   
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
                    let id = "id"
                    let data = document.data()
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let groups = data["groups"] as? Bool ?? false
                    let friends = data["friends"] as? Bool ?? false
                    let newUser = User(username: username, documentId: document.documentID, email: email, groups: groups, friends: friends, id: id)
                    self.users.append(newUser)
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell {
            cell.layer.cornerRadius = 0
            let user = users[indexPath.row]
            cell.textLabel?.text = user.username
            cell.textLabel?.textColor = UIColor.white
            return cell
        }   else {
            return UITableViewCell()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChatVC" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as? ChatVC
                controller?.user = users[indexPath.row]
                print(user?.id)
            }
        }
    }
    
}
