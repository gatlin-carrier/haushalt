//
//  ChoreCellCVC.swift
//  Haushalt
//
//  Created by Gatlin Carrier on 2/6/19.
//  Copyright © 2019 Gatlin Carrier. All rights reserved.
//

import UIKit

class ChoreCellCVC: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var doerLabel: UILabel!
    @IBOutlet weak var choreTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(chore: Chore) {
        dueDateLabel.text = chore.dueDate
        doerLabel.text = chore.doer
        choreTextLabel.text = chore.choreText
    }

}
