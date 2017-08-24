//
//  ItemDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class ItemDetailsViewController: BaseViewViewController {

    //MARK : - Outlets
    
    //MARK : - Vars
    internal var item: Item!
    
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
        self.title = self.item.name
    }
}
