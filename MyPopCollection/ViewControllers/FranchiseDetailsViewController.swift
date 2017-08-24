//
//  FranchiseDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class FranchiseDetailsViewController: BaseViewViewController {

    //MARK : - Outlets
    
    //MARK : - Vars
    internal var franchise: Franchise!
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.title = self.franchise.name
    }
}
