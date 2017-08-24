//
//  MyCollectionViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK : - Vars

    //MARK : - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setups
    
    func setupViews() {

    }
    
    //MARK: - NavigationBar
    
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(buttonAddTouched))
    }

    //MARK: - Table View Methods
    
    func registerNibs() {
        self.tableView.register(UINib(nibName: "MyCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCollectionTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseHelper.getAllMyCollections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MyCollectionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MyCollectionTableViewCell", for: indexPath) as? MyCollectionTableViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("MyCollectionTableViewCell", owner: self, options: nil)![0] as! MyCollectionTableViewCell
        }
        
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
    
    }
}
