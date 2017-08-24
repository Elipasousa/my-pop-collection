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
    
    //MARK : - Vars
    var myCollections: [MyCollection] = []
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        reloadMyCollections()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(buttonAddTouched))
    }
    
    //MARK: - Table View Methods
    
    func reloadMyCollections() {
        self.myCollections.removeAll()
        self.myCollections = DatabaseHelper.getAllMyCollections()
        self.tableView.reloadData()
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
        cell.setName(self.myCollections[indexPath.row].name)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //MARK : - Actions
    
    func buttonAddTouched() {
        presentAddNewCollection()
    }
    
    //MARK : - WireFrame
    
    func presentAddNewCollection() {
        let alert = UIAlertController(title: "Add New Collection",
                                      message: "Enter your collection name",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Add",
                                      style: .default,
                                      handler: { (_) in
                                        let textField = alert.textFields!.first!
                                        if let text = textField.text {
                                            addNewCollection(withName: text)
                                        }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        //MARK : - Auxs
        
        func addNewCollection(withName name: String) {
            if !DatabaseHelper.existsCollection(withName: name) {
                let c = MyCollection()
                c.name = name
                DatabaseHelper.addMyCollection(c)
                self.reloadMyCollections()
            } else {
                self.showError(message: "Already exists a collection named '" + name + "'")
            }
        }
    }
}
