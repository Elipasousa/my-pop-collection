//
//  BaseViewViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class BaseViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setups
    
    func setupViews() {
        
    }
    
    //MARK: - NavigationBar
    
    func setupNavigationBar() {
        self.title = ""
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }

    //MARK: - Navigation
 
    func showError(withTitle title: String = "Attention", message: String?) {
    
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentMyCollectionDetails(fromCollection collection: MyCollection) {
        let vc: MyCollectionDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyCollectionDetailsViewController") as! MyCollectionDetailsViewController
        vc.collection = collection
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentFranchiseDetails(fromFranchise franchise: Franchise) {
        let vc: FranchiseDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FranchiseDetailsViewController") as! FranchiseDetailsViewController
        vc.franchise = franchise
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentItemDetails(fromItem item: Item) {
        let vc: ItemDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentAddItem(_ item: Item) {
        let vc: AddNewItemViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewItemViewController") as! AddNewItemViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
