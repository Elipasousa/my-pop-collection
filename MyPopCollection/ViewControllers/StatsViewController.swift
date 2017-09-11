//
//  StatsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class StatsViewController: BaseViewViewController {

    //MARK : - Outlets
    @IBOutlet weak var labelTotalItems: UILabel!
    @IBOutlet weak var labelWishlistItems: UILabel!
    @IBOutlet weak var labelPaidPrice: UILabel!
    @IBOutlet weak var labelEstimatedValue: UILabel!

    //MARK : - Vars
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()

        let totalItems = DatabaseHelper.getAllItemsFromMyCollection()
        let wishlistItems = DatabaseHelper.getAllItemsFromMyWishlist()

        var paidPrice = 0.0
        var estimatedValue = 0.0
        
        for i in totalItems {
            paidPrice += i.paidPrice
            estimatedValue += i.estimatedValue
        }
        
        self.labelTotalItems.text = "\(totalItems.count)"
        self.labelWishlistItems.text = "\(wishlistItems.count)"
        self.labelPaidPrice.text = "\(paidPrice)"
        self.labelEstimatedValue.text = "\(estimatedValue)"
    }
}
