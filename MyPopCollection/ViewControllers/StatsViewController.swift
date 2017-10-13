//
//  StatsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import PKHUD

class StatsViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var labelTotalItems: UILabel!
    @IBOutlet weak var labelWishlistItems: UILabel!
    @IBOutlet weak var labelPaidPrice: UILabel!
    @IBOutlet weak var labelEstimatedValue: UILabel!
    @IBOutlet weak var topTenTableView: UITableView!
    @IBOutlet weak var constraintHeightTopTenTableView: NSLayoutConstraint!
    @IBOutlet weak var labelNoItems: UILabel!
    
    //MARK: - Vars
    internal var allSortedItems: [Item] = []
    internal var wishlistItems: [Item] = []

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allSortedItems = DatabaseHelper.getAllItemsFromMyCollection().sorted(by: {$0.estimatedValue > $1.estimatedValue})
        self.wishlistItems = DatabaseHelper.getAllItemsFromMyWishlist()
        setupMyStats()
        reloadTopTen()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()
        self.title = "Stats"
    }
    
    //MARK: - Aux

    func setupMyStats() {
        var paidPrice = 0.0
        var estimatedValue = 0.0
        
        for i in self.allSortedItems {
            paidPrice += i.paidPrice
            estimatedValue += i.estimatedValue
        }
        
        self.labelTotalItems.text = "\(self.allSortedItems.count)"
        self.labelWishlistItems.text = "\(self.wishlistItems.count)"
        self.labelPaidPrice.text = "\(paidPrice)"
        self.labelEstimatedValue.text = "\(estimatedValue)"
    }
    
    //MARK: - Table View Methods
    
    func reloadTopTen() {
        if self.allSortedItems.count == 0 {
            self.labelNoItems.isHidden = false
            self.topTenTableView.isHidden = true
        } else {
            self.labelNoItems.isHidden = true
            self.topTenTableView.isHidden = false
            self.topTenTableView.reloadData()
            
            self.constraintHeightTopTenTableView.constant = CGFloat(90.0) * CGFloat((self.allSortedItems.count > 10 ? 10 : self.allSortedItems.count))
        }
    }
    
    func registerNibs() {
        self.topTenTableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSortedItems.count > 10 ? 10 : self.allSortedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: WishlistTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as? WishlistTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("WishlistTableViewCell", owner: self, options: nil)![0] as! WishlistTableViewCell
        }
        cell.setItem(self.allSortedItems[indexPath.row], showCategory: true, showPrice: true)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.presentItemDetails(fromItem: self.wishlist[indexPath.row])
    }
    
    //MARK: - Actions
    
    @IBAction func updateDatabaseTouched(_ sender: Any) {
        DispatchQueue.main.async {
            HUD.show(.systemActivity)
            ServiceMock.sharedInstance.parseItems {
                ServiceMock.sharedInstance.parseFranchises {
                    ServiceMock.sharedInstance.parseCategories {
                        HUD.hide()
                    }
                }
            }
        }
    }
}
