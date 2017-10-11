//
//  FranchiseDetailsViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit
import PKHUD

class FranchiseDetailsViewController: BaseViewViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK : - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonAddToWishlist: UIButton!
    @IBOutlet weak var buttonAddToMyCollection: UIButton!
    
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
        self.buttonAddToWishlist.isHidden = true
        self.buttonAddToMyCollection.isHidden = true
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
    
    @IBAction func addToWishlistTouched(_ sender: Any) {
        for identifier in self.bulkSelectedIdentifiers {
            DatabaseHelper.addItemToMyWishlist(withIdentifier: identifier)
        }
        self.buttonCancelTouched()
        HUD.flash(.labeledSuccess(title: "Done", subtitle: nil), delay: HUDTime.success)
    }
    
    @IBAction func addToMyCollectionTouched(_ sender: Any) {
        for identifier in self.bulkSelectedIdentifiers {
            DatabaseHelper.addItemToMyCollection(withIdentifier: identifier)
        }
        self.buttonCancelTouched()
        HUD.flash(.labeledSuccess(title: "Done", subtitle: nil), delay: HUDTime.success)

    }
    
    @objc func buttonSelectTouched() {
        self.isBulkSelecting = true
        self.buttonAddToWishlist.isHidden = false
        self.buttonAddToMyCollection.isHidden = false
        setupNavigationBarButtons()
        self.collectionView.reloadData()
    }
    
    @objc func buttonCancelTouched() {
        self.isBulkSelecting = false
        self.buttonAddToWishlist.isHidden = true
        self.buttonAddToMyCollection.isHidden = true
        self.bulkSelectedIdentifiers = []
        setupNavigationBarButtons()
        self.collectionView.reloadData()
    }
}
