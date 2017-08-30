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
    var letters: [String] = []
    var franchises = [String: [Franchise]]()
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        parseFranchises()
        self.tableView.reloadData()
    }

    //MARK: - Setups
    
    override func setupViews() {

    }
    
    func parseFranchises() {
        self.franchises.removeAll()
        let letters = CharacterSet.letters

        for f in DatabaseHelper.getAllFranchises() {
            var firstCharacter = String(f.name.characters.first!)
            
            if !letters.contains(firstCharacter.unicodeScalars.first!) {
                firstCharacter = "#"
            }
            
            var a = self.franchises[firstCharacter]
            if a == nil {
                a = []
            }
            
            a!.append(f)
            self.franchises[firstCharacter] = a
        }
        self.letters = Array(self.franchises.keys).sorted(by: {$0 < $1})
    }
    
    //MARK: - Table View Methods
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "FranchiseTableViewCell", bundle: nil), forCellReuseIdentifier: "FranchiseTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.letters.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("SectionHeaderTitleView", owner: self, options: nil)![0] as! SectionHeaderTitleView
        header.setTitle(self.letters[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.letters
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return self.letters.index(of: title)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.franchises[self.letters[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FranchiseTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "FranchiseTableViewCell", for: indexPath) as? FranchiseTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("FranchiseTableViewCell", owner: self, options: nil)![0] as! FranchiseTableViewCell
        }
        let a = self.franchises[self.letters[indexPath.section]]!
        cell.setName(a[indexPath.row].name)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //presentFranchiseDetails(fromFranchise: self.franchises[indexPath.row])
    }
}
