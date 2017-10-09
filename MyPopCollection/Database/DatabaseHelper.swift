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
        
        /*try! realm.write {
         realm.delete(item)
         }*/
        
        let predicate = NSPredicate(format: "name = %@", item.name)
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
        
        /*try! realm.write {
         realm.delete(item)
         }*/
        
        let predicate = NSPredicate(format: "name = %@", franchise.name)
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
        
        /*try! realm.write {
         realm.delete(item)
         }*/
        
        let predicate = NSPredicate(format: "name = %@", category.name)
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
    
    class func addItemToMyWishlist(withName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyWishlist = true
        }
    }
    
    class func removeItemFromMyWishlist(withName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyWishlist = false
        }
    }
    
    class func updateItem(withName name: String, paidPrice: Double, estimatedValue: Double, dateBought: Date, rarity: String, condition: String, itemState: String, boxState: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
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
        increaseItemOfFranchiseFromMyCollection(franchiseWithName: item.franchise)
    }
    
    class func removeItem(withName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        try! realm.write {
            item.inMyCollection = false
        }
        decreaseItemOfFranchiseFromMyCollection(franchiseWithName: item.franchise)
    }
    
    //MARK : - Franchises
    
    class func getFranchises(withSearch: String?) -> [Franchise] {
        let realm = try! Realm()
        
        if withSearch != nil && !withSearch!.isEmpty {
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", withSearch!)
            return Array(realm.objects(Franchise.self).filter(predicate))

        } else {
            return Array(realm.objects(Franchise.self))
        }
    }
    
    class func increaseItemOfFranchiseFromMyCollection(franchiseWithName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let franchise = realm.objects(Franchise.self).filter(predicate).first

        try! realm.write {
            franchise?.itemsInMyCollection += 1
        }
    }
    
    class func decreaseItemOfFranchiseFromMyCollection(franchiseWithName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let franchise = realm.objects(Franchise.self).filter(predicate).first
        
        try! realm.write {
            franchise?.itemsInMyCollection -= 1
        }
    }

    class func getAllFranchisesFromMyCollection() -> [Franchise] {
        let realm = try! Realm()
        return Array(realm.objects(Franchise.self).filter("itemsInMyCollection != 0")).sorted(by: {$0.name < $1.name})
    }
    
    class func getItemsFromFranchise(fromFranchise franchise: Franchise, inMyCollectionOnly: Bool) -> [Item] {
        let realm = try! Realm()
        
        var predicate = NSPredicate(format: "franchise = %@", franchise.name)
        if inMyCollectionOnly {
            predicate = NSPredicate(format: "franchise = %@ AND inMyCollection = true", franchise.name)
        }
        
        return Array(realm.objects(Item.self).filter(predicate)).sorted(by: {$0.number < $1.number})
    }
    
    //MARK : - Categories

    class func getCategories() -> [Category] {
        let realm = try! Realm()
        return Array(realm.objects(Category.self)).sorted(by: {$0.name < $1.name})
    }
    
    class func getItemsFromCategory(_ category: Category, withSearch: String?) -> [Item] {
        let realm = try! Realm()
        var predicate = NSPredicate(format: "category = %@", category.name)

        if withSearch != nil && !withSearch!.isEmpty {
            predicate = NSPredicate(format: "category = %@ AND name CONTAINS[c] %@", category.name, withSearch!)
        }
        return Array(realm.objects(Item.self).filter(predicate)).sorted(by: {$0.number < $1.number})
    }
}
