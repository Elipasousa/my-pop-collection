//
//  DatabaseHelper.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 24/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseHelper {
    
    //MARK : - Database

    class func addItem(_ item: Item) {
        let realm = try! Realm()

        let predicate = NSPredicate(format: "identifier = %d", item.identifier)
        let a = Array(realm.objects(Item.self).filter(predicate))
        
        if a.count != 0 {
            return
        }
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    class func addFranchise(_ franchise: Franchise) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", franchise.identifier)
        let a = Array(realm.objects(Franchise.self).filter(predicate))
        
        if a.count != 0 {
            return
        }
        
        try! realm.write {
            realm.add(franchise)
        }
    }
    
    class func addCategory(_ category: Category) {
        let realm = try! Realm()

        let predicate = NSPredicate(format: "identifier = %d", category.identifier)
        let a = Array(realm.objects(Category.self).filter(predicate))
        
        if a.count != 0 {
            return
        }
        
        try! realm.write {
            realm.add(category)
        }
    }
    
    //MARK : - Items
    
    class func getAllItemsFromMyCollection() -> [Item] {
        let realm = try! Realm()
        return Array(realm.objects(Item.self).filter("inMyCollection == true"))
    }
    
    class func getAllItemsFromMyWishlist() -> [Item] {
        let realm = try! Realm()
        return Array(realm.objects(Item.self).filter("inMyWishlist == true"))
    }
    
    class func addItemToMyWishlist(withIdentifier identifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyWishlist = true
        }
    }
    
    class func removeItemFromMyWishlist(withIdentifier identifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyWishlist = false
        }
    }
    
    class func changeItemFranchise(withItemIdentifier itemIdentifier: Int, toFranchiseIdentifier franchiseIdentifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", itemIdentifier)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        if item.inMyCollection {
            DatabaseHelper.decreaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier: item.franchiseId)
            DatabaseHelper.increaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier: franchiseIdentifier)
        }
        
        try! realm.write {
            item.franchiseId = franchiseIdentifier
        }
    }
    
    class func updateItem(withIdentifier identifier: Int, paidPrice: Double, estimatedValue: Double, dateBought: Date, rarity: String, condition: String, itemState: String, boxState: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.paidPrice = paidPrice
            item.estimatedValue = estimatedValue
            item.dateBought = dateBought
            item.rarity = rarity
            item.condition = condition
            item.itemState = itemState
            item.boxState = boxState
            item.inMyCollection = true
            item.inMyWishlist = false
        }
        increaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier: item.franchiseId)
    }
    
    class func removeItem(withIdentifier identifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyCollection = false
        }
        decreaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier: item.franchiseId)
    }
    
    //MARK : - Franchises
    
    class func getFranchise(withIdentifier identifier: Int) -> Franchise {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        return realm.objects(Franchise.self).filter(predicate).first!
    }
    
    class func getFranchises(withSearch: String?) -> [Franchise] {
        let realm = try! Realm()
        
        if withSearch != nil && !withSearch!.isEmpty {
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", withSearch!)
            return Array(realm.objects(Franchise.self).filter(predicate))

        } else {
            return Array(realm.objects(Franchise.self))
        }
    }
    
    class func increaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier identifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let franchise = realm.objects(Franchise.self).filter(predicate).first

        try! realm.write {
            franchise?.itemsInMyCollection += 1
        }
    }
    
    class func decreaseItemAmountOfFranchiseFromMyCollection(withFranchiseIdentifier identifier: Int) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        let franchise = realm.objects(Franchise.self).filter(predicate).first
        
        try! realm.write {
            franchise?.itemsInMyCollection -= 1
        }
    }

    class func getAllFranchisesFromMyCollection() -> [Franchise] {
        let realm = try! Realm()
        return Array(realm.objects(Franchise.self).filter("itemsInMyCollection != 0")).sorted(by: {$0.name < $1.name})
    }
    
    class func getItemsFromFranchise(withIdentifier identifier: Int, inMyCollectionOnly: Bool) -> [Item] {
        let realm = try! Realm()
        
        var predicate = NSPredicate(format: "franchiseId= %d", identifier)
        if inMyCollectionOnly {
            predicate = NSPredicate(format: "franchiseId = %d AND inMyCollection = true", identifier)
        }
        
        return Array(realm.objects(Item.self).filter(predicate)).sorted(by: {$0.number < $1.number})
    }
    
    //MARK : - Categories
    
    class func getCategory(withIdentifier identifier: Int) -> Category {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "identifier = %d", identifier)
        return realm.objects(Category.self).filter(predicate).first!
    }

    class func getCategories() -> [Category] {
        let realm = try! Realm()
        return Array(realm.objects(Category.self)).sorted(by: {$0.name < $1.name})
    }
    
    class func getItemsFromCategory(withIdentifier identifier: Int, withSearch: String?) -> [Item] {
        let realm = try! Realm()
        var predicate = NSPredicate(format: "categoryIdentifier = %d", identifier)

        if withSearch != nil && !withSearch!.isEmpty {
            predicate = NSPredicate(format: "categoryIdentifier = %d AND name CONTAINS[c] %@", identifier, withSearch!)
        }
        return Array(realm.objects(Item.self).filter(predicate)).sorted(by: {$0.number < $1.number})
    }
}
