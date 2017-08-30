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
    
    //MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = DatabaseHelper.getItemsFromFranchise(fromFranchise: self.franchise, inMyCollectionOnly: false)
        registerNibs()
        self.collectionView.reloadData()
    }
    
    //MARK: - Setups
    
    override func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.title = self.franchise.name
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
        cell.setItem(self.items[indexPath.row])
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.presentItemDetails(fromItem: self.items[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((collectionView.frame.size.width - (15.0 * 3)) / 2)
        return CGSize(width: size, height: size * 1.2)
    }
}
