//
//  FranchiseDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class FranchiseDetailsViewController: BaseViewViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK : - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK : - Vars
    internal var franchise: Franchise!
    internal var items: [Item]!
    
    private var isBulkSelecting: Bool = false
    private var bulkSelectedIdentifiers: [Int] = []

    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupNavigationBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.items = DatabaseHelper.getItemsFromFranchise(withIdentifier: self.franchise.identifier, inMyCollectionOnly: false)
        self.collectionView.reloadData()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        super.setupViews()
        self.title = self.franchise.name
    }
    
    func setupNavigationBarButtons() {
        if self.isBulkSelecting {
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(buttonCancelTouched))
            self.navigationItem.rightBarButtonItems = [cancelButton]
            
        } else {
            let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(buttonSelectTouched))
            self.navigationItem.rightBarButtonItems = [selectButton]
        }
    }
    
    // MARK: - Collection View Methods
    
    func registerNibs() {
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ItemCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("ItemCollectionViewCell", owner: self, options: nil)![0] as! ItemCollectionViewCell
        }
        let item = self.items[indexPath.row]
        cell.setItem(item)
        cell.setBulkSelectionMode(isOn: self.isBulkSelecting, isSelected: self.bulkSelectedIdentifiers.contains(item.identifier))
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let item = self.items[indexPath.row]
        
        if self.isBulkSelecting {
            if let index = self.bulkSelectedIdentifiers.index(of: item.identifier) {
                self.bulkSelectedIdentifiers.remove(at: index)
            } else {
                self.bulkSelectedIdentifiers.append(item.identifier)
            }
            let cell = collectionView.cellForItem(at: indexPath) as! ItemCollectionViewCell
            cell.setBulkSelectionMode(isOn: self.isBulkSelecting, isSelected: self.bulkSelectedIdentifiers.contains(item.identifier))
        } else {
            self.presentItemDetails(fromItem: item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((collectionView.frame.size.width - (15.0 * 3)) / 2)
        return CGSize(width: size, height: size * 1.2)
    }
    
    //MARK: - Actions
    
    @objc func buttonSelectTouched() {
        self.isBulkSelecting = true
        setupNavigationBarButtons()
        self.collectionView.reloadData()
    }
    
    @objc func buttonCancelTouched() {
        self.isBulkSelecting = false
        self.bulkSelectedIdentifiers = []
        setupNavigationBarButtons()
        self.collectionView.reloadData()
    }
}
