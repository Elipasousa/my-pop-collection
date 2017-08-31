//
//  MyCollectionViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class MyCollectionViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelNoItems: UILabel!

    //MARK : - Vars
    var myCollections: [Franchise] = []
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMyCollections()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.title = "My Collection"
    }
    
    //MARK: - Table View Methods
    
    func reloadMyCollections() {
        self.myCollections.removeAll()
        self.myCollections = DatabaseHelper.getAllFranchisesFromMyCollection()
        
        if self.myCollections.count == 0 {
            self.labelNoItems.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.labelNoItems.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "MyCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCollectionTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MyCollectionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MyCollectionTableViewCell", for: indexPath) as? MyCollectionTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("MyCollectionTableViewCell", owner: self, options: nil)![0] as! MyCollectionTableViewCell
        }
        cell.setFranchise(self.myCollections[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentMyCollectionDetails(fromFranchise: self.myCollections[indexPath.row])
    }
}
