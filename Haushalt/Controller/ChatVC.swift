//
//  ChatVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 2/27/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SendMessageLabel: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var SendMessageView: UIView!
    //Variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "SentMessageCell", bundle: nil), forCellWithReuseIdentifier: "sentMessageCell")
        
        SendMessageLabel.layer.cornerRadius = 9.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMessageCell", for: indexPath) as! SentMessageCell
        
        cell.layer.cornerRadius = 10.0
        
        let messageArray = ["First Message", "SecondMessage"]
        
        cell.MessageContentsLabel.text = messageArray[indexPath.row]
        
        return cell
    }
    
    

    

}
