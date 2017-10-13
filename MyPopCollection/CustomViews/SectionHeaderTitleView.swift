//
//  SectionHeaderTitleView.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 30/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class SectionHeaderTitleView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK: - Vars
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitle(_ title: String) {
        self.labelTitle.text = title
    }
}
