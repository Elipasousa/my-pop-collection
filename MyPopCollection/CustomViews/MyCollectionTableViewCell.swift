//
//  MyCollectionTableViewCell.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class MyCollectionTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: - Vars
    
    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Setup

    func setupViews() {

    }
    
    func setFranchise(_ franchise: Franchise) {
        if let image = franchise.image {
            self.imageViewLogo.sd_setShowActivityIndicatorView(true)
            self.imageViewLogo.sd_setIndicatorStyle(.gray)
            self.imageViewLogo.sd_setImage(with: URL(string: image), placeholderImage: nil)
            self.imageViewLogo.isHidden = false
            self.labelName.isHidden = true
        } else {
            self.labelName.text = franchise.name
            self.imageViewLogo.isHidden = true
            self.labelName.isHidden = false
        }
    }
}
