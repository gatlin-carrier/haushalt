//
//  ChoresVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 12/19/18.
//  Copyright © 2018 Gatlin Carrier. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import Firebase
//
//class ChoresVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//
//    //Outlets
//    @IBOutlet private weak var tableView: UITableView!
//
//
//    //Variables
//
//    private var handle: AuthStateDidChangeListenerHandle?
//    
//    private var chores = [Chore]()
//
//    private var choresCollectionRef : CollectionReference!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = 100.0
//        tableView.layer.cornerRadius = 12
//
//        choresCollectionRef = Firestore.firestore().collection("chores")
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        choresCollectionRef.getDocuments{ ( snapshot, error ) in
//        if let err = error {
//            debugPrint("Error fetching docs: \(err)")
//        }
//        else {
//            guard let snap = snapshot else { return }
//            for document in snap.documents {
//                let data = document.data()
//                let username = data["username"] as? String ?? ""
//                let dueDate = data["dueDate"] as? String ?? ""
//                let doer = data["doer"] as? String ?? ""
//                let choreText = data["choreText"] as? String ?? ""
//                let deleted = data["deleted"] as? Bool ?? false
//                let documentId = document.documentID
//
//                let newChore = Chore(username: username, choreText: choreText, dueDate: dueDate, deleted: deleted, documentId: documentId, doer: doer)
//                self.chores.append(newChore)
//                }
//            self.tableView.reloadData()
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chores.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "choreCell", for: indexPath) as? ChoreCell {
//            cell.configureCell(chore: chores[indexPath.row])
//            return cell
//        } else {
//           return UITableViewCell()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
//    }
//
//
//
//    @IBAction func logoutTapped(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signoutError as NSError {
//            debugPrint("Error signing out: \(signoutError)")
//        }
//    }
//}
//
//
//
