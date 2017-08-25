//
//  AddNewItemViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class AddNewItemViewController: BaseViewViewController {

    //MARK : - Outlets
    // --- info ---
    @IBOutlet weak var imageViewPicture: UIImageView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFranchise: UILabel!
    // --- quantity ---
    @IBOutlet weak var labelQuantityTag: UILabel!
    @IBOutlet weak var buttonQuantityDecrease: UIButton!
    @IBOutlet weak var labelQuantityValue: UILabel!
    @IBOutlet weak var buttonQuantityIncrease: UIButton!
    // --- rarity ---
    @IBOutlet weak var labelRarityTag: UILabel!
    @IBOutlet weak var labelRarityValue: UILabel!
    // --- condition ---
    @IBOutlet weak var labelConditionTag: UILabel!
    @IBOutlet weak var viewConditionCIB: UIView!
    @IBOutlet weak var buttonConditionCIB: UIButton!
    @IBOutlet weak var viewConditionPopOnly: UIView!
    @IBOutlet weak var buttonConditionPopOnly: UIButton!
    @IBOutlet weak var viewConditionBoxOnly: UIView!
    @IBOutlet weak var buttonConditionBoxOnly: UIButton!
    // --- pop state ---
    @IBOutlet weak var labelPopStateTag: UILabel!
    @IBOutlet weak var labelPopStateValue: UILabel!
    // --- box state ---
    @IBOutlet weak var labelBoxStateTag: UILabel!
    @IBOutlet weak var labelBoxStateValue: UILabel!
    // --- paid price ---
    @IBOutlet weak var labelPaidPriceTag: UILabel!
    @IBOutlet weak var textFieldPaidPrice: UITextField!
    // --- estimated value ---
    @IBOutlet weak var labelEstimatedValueTag: UILabel!
    @IBOutlet weak var textFieldEstimatedValue: UITextField!
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(buttonDoneTouched))
    }
    
    //MARK: - Actions
    
    func buttonDoneTouched() {
        
    }
    
    //MARK: - Aux
    
    func setItem() {
        self.labelName.text = self.item.name
        self.labelFranchise.text = self.item.franchise
        self.labelNumber.text = "\(self.item.number)"
        
        if let image = self.item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil)
        }
    }
    
    //MARK: - Quantity

    @IBAction func quantityIncreaseTouched(_ sender: Any) {
        var quantity = Int(self.labelQuantityValue.text!)!
        quantity += 1
        self.labelQuantityValue.text = "\(quantity)"
    }
    
    @IBAction func quantityDecreaseTouched(_ sender: Any) {
        var quantity = Int(self.labelQuantityValue.text!)!
        if quantity > 1 {
            quantity -= 1
            self.labelQuantityValue.text = "\(quantity)"
        }
    }
    
    //MARK: - Rarity

    @IBAction func rarityTouched(_ sender: Any) {
        
    }
    
    //MARK: - Condition

    @IBAction func cibTouched(_ sender: Any) {
        self.buttonConditionCIB.isSelected = true
        self.buttonConditionPopOnly.isSelected = false
        self.buttonConditionBoxOnly.isSelected = false
        self.viewConditionCIB.alpha = 1.0
        self.viewConditionPopOnly.alpha = 0.3
        self.viewConditionBoxOnly.alpha = 0.3
    }
    
    @IBAction func popOnlyTouched(_ sender: Any) {
        self.buttonConditionCIB.isSelected = true
        self.buttonConditionPopOnly.isSelected = false
        self.buttonConditionBoxOnly.isSelected = false
        self.viewConditionCIB.alpha = 0.3
        self.viewConditionPopOnly.alpha = 1.0
        self.viewConditionBoxOnly.alpha = 0.3
    }
    
    @IBAction func boxOnlyTouched(_ sender: Any) {
        self.buttonConditionCIB.isSelected = false
        self.buttonConditionPopOnly.isSelected = false
        self.buttonConditionBoxOnly.isSelected = true
        self.viewConditionCIB.alpha = 0.3
        self.viewConditionPopOnly.alpha = 0.3
        self.viewConditionBoxOnly.alpha = 1.0
    }
    
    //MARK: - Pop State
    
    @IBAction func popStateTouched(_ sender: Any) {
        
    }
    
    //MARK: - Box State
    
    @IBAction func boxStateTouched(_ sender: Any) {
        
    }
    
    //MARK: - Date Bought

    @IBAction func dateBoughtTouched(_ sender: Any) {
        
    }
}
