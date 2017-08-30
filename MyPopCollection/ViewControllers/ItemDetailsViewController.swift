//
//  ItemDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class ItemDetailsViewController: BaseViewViewController {

    //MARK : - Outlets
    // --- info ---
    @IBOutlet weak var imageViewPicture: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageViewAligned!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    // --- collection ---
    @IBOutlet weak var labelInMyCollection: UILabel!
    @IBOutlet weak var stackViewInMyCollection: UIStackView!
    // --- rarity ---
    @IBOutlet weak var labelRarityTag: UILabel!
    @IBOutlet weak var labelRarityValue: UILabel!
    // --- condition ---
    @IBOutlet weak var labelConditionTag: UILabel!
    @IBOutlet weak var imageViewCondition: UIImageView!
    @IBOutlet weak var labelConditionValue: UILabel!
    // --- pop state ---
    @IBOutlet weak var labelPopStateTag: UILabel!
    @IBOutlet weak var labelPopStateValue: UILabel!
    // --- box state ---
    @IBOutlet weak var labelBoxStateTag: UILabel!
    @IBOutlet weak var labelBoxStateValue: UILabel!
    // --- paid price ---
    @IBOutlet weak var labelPaidPriceTag: UILabel!
    @IBOutlet weak var labelPaidPriceValue: UILabel!
    // --- estimated value ---
    @IBOutlet weak var labelEstimatedValueTag: UILabel!
    @IBOutlet weak var labelEstimatedValueValue: UILabel!
    // --- date bought ---
    @IBOutlet weak var labelDateBoughtTag: UILabel!
    @IBOutlet weak var labelDateBoughtValue: UILabel!
    
    //MARK : - Vars
    internal var item: Item!
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItem()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        self.viewNumber.layer.cornerRadius = self.viewNumber.frame.size.height/2
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.title = self.item.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(buttonAddTouched))
    }
    
    //MARK: - Actions
    
    func buttonAddTouched() {
        self.presentAddItem(self.item)
    }

    //MARK: - Aux
    
    func setItem() {
        self.labelName.text = self.item.name
        self.labelCategory.text = self.item.category
        self.labelNumber.text = "\(self.item.number)"
        
        if let image = self.item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil, completed: { (image, error, cacheTypr, url) in
                if let image = image {
                    let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
                    let clippedRect = CGRect(x: 0.0, y: 0.0, width: contextImage.size.width * 0.4, height: contextImage.size.height)
                    let imageRef = contextImage.cgImage!.cropping(to: clippedRect)!
                    self.imageViewBackground.image = UIImage(cgImage: imageRef)
                }
            })
        }
        
        if item.inMyCollection {
            self.labelInMyCollection.isHidden = true
            self.stackViewInMyCollection.isHidden = false
            self.imageViewBackground.isHidden = false
            
            self.labelRarityValue.text = self.item.rarity
            self.labelConditionValue.text = self.item.condition
            self.labelPopStateValue.text = self.item.itemState
            self.labelBoxStateValue.text = self.item.boxState
            self.labelPaidPriceValue.text = "\(self.item.paidPrice)"
            self.labelEstimatedValueValue.text = "\(self.item.estimatedValue)"

            switch self.item.condition {
                case Condition.CIB.rawValue:
                    self.imageViewCondition.image = UIImage(named: "popwithbox")
                case Condition.PopOnly.rawValue:
                    self.imageViewCondition.image = UIImage(named: "poponly")
                case Condition.BoxOnly.rawValue:
                    self.imageViewCondition.image = UIImage(named: "boxonly")
                default:
                    break
            }
        } else {
            self.labelInMyCollection.text = "You don't have this item in your collection"
            self.labelInMyCollection.isHidden = false
            self.stackViewInMyCollection.isHidden = true
            self.imageViewBackground.isHidden = true
        }
    }
}
