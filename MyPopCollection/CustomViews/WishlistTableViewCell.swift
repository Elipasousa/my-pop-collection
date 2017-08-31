//
//  WishlistTableViewCell.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 31/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    //MARK : - Outlets
    @IBOutlet weak var imageViewPicture: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!

    //MARK : - Vars
    
    //MARK : - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK : - Setup
    
    func setupViews() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Colors.clearGray.cgColor
    }
    
    func setItem(_ item: Item) {
        self.labelName.text = item.name
        self.labelCategory.text = item.category

        if let image = item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil)
        }
    }
}
