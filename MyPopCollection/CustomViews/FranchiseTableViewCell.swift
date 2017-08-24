//
//  FranchiseTableViewCell.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class FranchiseTableViewCell: UITableViewCell {
    
    //MARK : - Outlets
    @IBOutlet weak var labelName: UILabel!
    
    //MARK : - Vars
    
    //MARK : - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setName(_ name: String) {
        self.labelName.text = name
    }
}
