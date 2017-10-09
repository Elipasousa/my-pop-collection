//
//  SearchCategoryViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 09/10/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class SearchCategoryViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelNoResultsFound: UILabel!
    
    //MARK : - Vars
    internal var categories: [Category] = []

    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCategories()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()
        self.title = "Search"
    }
    
    func reloadCategories() {
        self.categories = DatabaseHelper.getCategories()
        
        if self.categories.isEmpty {
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
        self.tableView.register(UINib(nibName: "FranchiseTableViewCell", bundle: nil), forCellReuseIdentifier: "FranchiseTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FranchiseTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "FranchiseTableViewCell", for: indexPath) as? FranchiseTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("FranchiseTableViewCell", owner: self, options: nil)![0] as! FranchiseTableViewCell
        }
        cell.setName(self.categories[indexPath.row].name)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentCategoryDetails(fromCategory: self.categories[indexPath.row])
    }
}

