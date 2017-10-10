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
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    
    //MARK : - Vars
    
    //MARK : - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK : - Setup
    
    func setupViews() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Colors.clearGray.cgColor
        
        self.viewNumber.layer.cornerRadius = self.viewNumber.frame.size.height/2
    }
    
    func setItem(_ item: Item) {
        self.labelName.text = item.name
        
        if item.number != -1 {
            self.labelNumber.text = "\(item.number)"
            self.viewNumber.isHidden = false
        } else {
            self.viewNumber.isHidden = true
        }
        
        if let image = item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil)
        }
    }
}
