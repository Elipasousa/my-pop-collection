//
//  ItemCollectionViewCell.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    //MARK : - Outlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewPicture: UIImageView!

    //MARK : - Vars
    
    //MARK : - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItem(_ item: Item) {
        self.labelName.text = item.name
        
        if let image = item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil)
        }
    }
}
