//
//  ChoresCVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 1/8/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "choreCell"

class ChoresCVC: UICollectionViewController {
    
    //Variables
    private var chores = [Chore]()
    
    private var choresCollectionRef : CollectionReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        choresCollectionRef = Firestore.firestore().collection("chores")
     
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return chores.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return chores.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "choreCell", for: indexPath) as? ChoreCellCVC {
            cell.configureCell(chore: chores[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        choresCollectionRef.getDocuments{ ( snapshot, error ) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }
            else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let username = data["username"] as? String ?? ""
                    let dueDate = data["dueDate"] as? String ?? ""
                    let doer = data["doer"] as? String ?? ""
                    let choreText = data["choreText"] as? String ?? ""
                    let deleted = data["deleted"] as? Bool ?? false
                    let documentId = document.documentID
                    
                    let newChore = Chore(username: username, choreText: choreText, dueDate: dueDate, deleted: deleted, documentId: documentId, doer: doer)
                    
                    self.chores.append(newChore)
                }
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
