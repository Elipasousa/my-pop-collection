//
//  FranchisePickerViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 09/10/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

protocol FranchisePickerProtocol: class {
    func didFinishPickingFranchise(withFranchise franchise: Franchise)
}

class FranchisePickerViewController: BaseViewViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelNoResultsFound: UILabel!
    
    //MARK : - Vars
    weak var delegate: FranchisePickerProtocol?
    var letters: [String] = []
    var franchises = [String: [Franchise]]()
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        reloadFranchises(fromArray: DatabaseHelper.getFranchises(withSearch: nil))
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()
        self.title = "Search"
    }
    
    func reloadFranchises(fromArray: [Franchise]) {
        if fromArray.isEmpty {
            self.labelNoResultsFound.isHidden = false
            self.tableView.isHidden = true
            return
        } else {
            self.labelNoResultsFound.isHidden = true
            self.tableView.isHidden = false
        }
        
        self.franchises.removeAll()
        let letters = CharacterSet.letters
        
        for f in fromArray {
            var firstCharacter = String(f.name.characters.first!).uppercased()
            
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
        
        for l in self.letters {
            self.franchises[l] = self.franchises[l]?.sorted(by: {$0.name < $1.name})
        }
        self.tableView.reloadData()
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
        let a = self.franchises[self.letters[indexPath.section]]!
        if let delegate = self.delegate {
            delegate.didFinishPickingFranchise(withFranchise: a[indexPath.row])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK : - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadFranchises(fromArray: DatabaseHelper.getFranchises(withSearch: searchText))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        reloadFranchises(fromArray: DatabaseHelper.getFranchises(withSearch: nil))
        self.searchBar.resignFirstResponder()
    }
}
