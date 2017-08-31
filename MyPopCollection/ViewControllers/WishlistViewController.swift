//
//  WishlistViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 31/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class WishlistViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelNoItems: UILabel!
    
    //MARK : - Vars
    var wishlist: [Item] = []
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWishlist()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.title = "Wishlist"
    }
    
    //MARK: - Table View Methods
    
    func reloadWishlist() {
        self.wishlist.removeAll()
        self.wishlist = DatabaseHelper.getAllItemsFromMyWishlist()
        
        if self.wishlist.count == 0 {
            self.labelNoItems.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.labelNoItems.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: WishlistTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as? WishlistTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("WishlistTableViewCell", owner: self, options: nil)![0] as! WishlistTableViewCell
        }
        cell.setItem(self.wishlist[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
