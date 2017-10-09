//
//  CategoryDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 09/10/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelNoResultsFound: UILabel!
    
    //MARK : - Vars
    internal var category: Category!
    internal var items: [Item] = []
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        self.items = DatabaseHelper.getItemsFromCategory(self.category, withSearch: nil)
        reloadItems()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()
    }
    
    func reloadItems() {
        if self.items.isEmpty {
            self.labelNoResultsFound.isHidden = false
            self.tableView.isHidden = true
            return
        } else {
            self.labelNoResultsFound.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Table View Methods
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: WishlistTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as? WishlistTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("WishlistTableViewCell", owner: self, options: nil)![0] as! WishlistTableViewCell
        }
        cell.setItem(self.items[indexPath.row], showCategory: false, showPrice: false)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentItemDetails(fromItem: self.items[indexPath.row])
    }
    
    //MARK : - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.items = DatabaseHelper.getItemsFromCategory(self.category, withSearch: searchText)
        reloadItems()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.items = DatabaseHelper.getItemsFromCategory(self.category, withSearch: nil)
        reloadItems()
        self.searchBar.resignFirstResponder()
    }
}
