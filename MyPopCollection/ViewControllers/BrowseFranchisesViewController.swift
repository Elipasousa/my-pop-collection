//
//  BrowseFranchisesViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class BrowseFranchisesViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!

    //MARK : - Vars
    let franchises: [Franchise] = ServiceMock.sharedInstance.getAllFranchises()
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        self.tableView.reloadData()
    }

    //MARK: - Setups
    
    override func setupViews() {

    }
    
    //MARK: - Table View Methods
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "FranchiseTableViewCell", bundle: nil), forCellReuseIdentifier: "FranchiseTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.franchises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FranchiseTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "FranchiseTableViewCell", for: indexPath) as? FranchiseTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("FranchiseTableViewCell", owner: self, options: nil)![0] as! FranchiseTableViewCell
        }
        cell.setName(self.franchises[indexPath.row].name)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentFranchiseDetails(fromFranchise: self.franchises[indexPath.row])
    }
}
