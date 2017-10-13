//
//  AddNewItemViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftDate
import PKHUD

class AddNewItemViewController: BaseViewViewController, UITextFieldDelegate {

    //MARK: - Outlets
    // --- info ---
    @IBOutlet weak var imageViewPicture: UIImageView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
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

    //MARK: - Vars
    internal var item: Item!

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarButtons()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()

        self.viewNumber.layer.cornerRadius = self.viewNumber.frame.size.height/2
        
        self.textFieldPaidPrice.addDoneCancelToolbar()
        self.textFieldEstimatedValue.addDoneCancelToolbar()
    }
    
    func setupNavigationBarButtons() {
        if item.inMyCollection {
            let doneButton = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .plain, target: self, action: #selector(buttonDoneTouched))
            let removeButton = UIBarButtonItem(image: UIImage(named: "ic_delete"), style: .plain, target: self, action: #selector(buttonRemoveTouched))
            removeButton.tintColor = Colors.normalRed
            self.navigationItem.rightBarButtonItems = [doneButton, removeButton]

        } else {
            let doneButton = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .plain, target: self, action: #selector(buttonDoneTouched))
            self.navigationItem.rightBarButtonItems = [doneButton]
        }
    }
    
    //MARK: - Actions
    
    func buttonDoneTouched() {
        var condition = Condition.CIB.rawValue
        if self.buttonConditionPopOnly.isSelected {
            condition = Condition.PopOnly.rawValue
        } else if self.buttonConditionPopOnly.isSelected {
            condition = Condition.BoxOnly.rawValue
        }
        
        let date = self.labelDateBoughtValue.text!.date(format: .custom("dd MMM yyyy"), fromRegion: nil)!.absoluteDate
        var paidPrice = 0.0
        var estimatedValue = 0.0

        if let number = NumberFormatter().number(from: self.textFieldPaidPrice.text!) {
            paidPrice = Double(number)
        }
        
        if let number = NumberFormatter().number(from: self.textFieldEstimatedValue.text!) {
            estimatedValue = Double(number)
        }
        
        DatabaseHelper.updateItem(withIdentifier: self.item.identifier,
                                  paidPrice: paidPrice,
                                  estimatedValue: estimatedValue,
                                  dateBought: date,
                                  rarity: self.labelRarityValue.text!,
                                  condition: condition,
                                  itemState: self.labelPopStateValue.text!,
                                  boxState: self.labelBoxStateValue.text!)
        
        HUD.flash(.labeledSuccess(title: "Done", subtitle: nil), delay: HUDTime.success) { finished in
            self.popViewController()
        }
    }
    
    func buttonRemoveTouched() {
        showRemoveConfirmation()
    }
    
    //MARK: - Aux
    
    func setItem() {
        self.labelName.text = self.item.name
        self.labelCategory.text = self.item.categoryName()
        self.labelNumber.text = "\(self.item.number)"
        
        if let image = self.item.image {
            self.imageViewPicture.sd_setShowActivityIndicatorView(true)
            self.imageViewPicture.sd_setIndicatorStyle(.gray)
            self.imageViewPicture.sd_setImage(with: URL(string: image), placeholderImage: nil)
        }
        
        self.textFieldPaidPrice.text = "\(self.item.paidPrice)"
        self.textFieldEstimatedValue.text = "\(self.item.estimatedValue)"
        self.labelDateBoughtValue.text = self.item.dateBought.string(format: .custom("dd MMM yyyy"))
        self.labelRarityValue.text = self.item.rarity
        self.labelPopStateValue.text = self.item.itemState
        self.labelBoxStateValue.text = self.item.boxState
        
        switch self.item.condition {
            case Condition.CIB.rawValue:
                cibTouched(self.buttonConditionCIB)
            case Condition.PopOnly.rawValue:
                popOnlyTouched(self.buttonConditionPopOnly)
            case Condition.BoxOnly.rawValue:
                boxOnlyTouched(self.buttonConditionBoxOnly)
            default:
                break
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: - Rarity

    @IBAction func rarityTouched(_ sender: Any) {
        self.view.endEditing(true)
        ActionSheetStringPicker.show(withTitle: "Pick rarity",
                                     rows: rarities,
                                     initialSelection: 0,
                                     doneBlock: { picker, index, value in
                                        self.labelRarityValue.text = value as? String
                                        
        }, cancel: { ActionStringCancelBlock in
        }, origin: self.view)
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
        self.buttonConditionCIB.isSelected = false
        self.buttonConditionPopOnly.isSelected = true
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
        self.view.endEditing(true)
        ActionSheetStringPicker.show(withTitle: "Pick pop state",
                                     rows: states,
                                     initialSelection: 0,
                                     doneBlock: { picker, index, value in
                                        self.labelPopStateValue.text = value as? String
                                        
        }, cancel: { ActionStringCancelBlock in
        }, origin: self.view)
    }
    
    //MARK: - Box State
    
    @IBAction func boxStateTouched(_ sender: Any) {
        self.view.endEditing(true)
        ActionSheetStringPicker.show(withTitle: "Pick box state",
                                     rows: states,
                                     initialSelection: 0,
                                     doneBlock: { picker, index, value in
                                        self.labelBoxStateValue.text = value as? String
                                        
        }, cancel: { ActionStringCancelBlock in
        }, origin: self.view)
    }
    
    //MARK: - Date Bought

    @IBAction func dateBoughtTouched(_ sender: Any) {
        self.view.endEditing(true)
        ActionSheetDatePicker.show(withTitle: "Pick date bought",
                                   datePickerMode: .date,
                                   selectedDate: Date(),
                                   doneBlock: { (picker, value, index) in
                                    let date = value as? Date
                                    self.labelDateBoughtValue.text = date!.string(format: .custom("dd MMM yyyy"))
        }, cancel: { ActionStringCancelBlock in
        }, origin: self.view)
    }
    
    //MARK: - Aux
    
    func showRemoveConfirmation(withTitle title: String = "Attention", message: String = "This action cannot be undone. Do you want to remove this item?") {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: { (_) in
                                        DatabaseHelper.removeItem(withIdentifier: self.item.identifier)
                                        self.popViewController()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
