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
    
    //MARK : - Items
    
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
    
    class func getAllItems(inMyCollectionOnly: Bool) -> [Item] {
        let realm = try! Realm()
        
        if inMyCollectionOnly {
            return Array(realm.objects(Item.self).filter("inMyCollection = true"))
        } else {
            return Array(realm.objects(Item.self))

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
        }
        
        addFranchiseToMyCollection(franchiseWithName: item.franchise)
    }
    
    //MARK : - Collections
    
    class func addFranchiseToMyCollection(franchiseWithName name: String) {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        let franchise = realm.objects(Franchise.self).filter(predicate).first

        try! realm.write {
            franchise?.inMyCollection = true
        }
    }

    class func getAllFranchisesFromMyCollection() -> [Franchise] {
        let realm = try! Realm()
        return Array(realm.objects(Franchise.self).filter("inMyCollection = true")).sorted(by: {$0.name < $1.name})
    }
    
    class func getItemsFromFranchise(fromFranchise franchise: Franchise, inMyCollectionOnly: Bool) -> [Item] {
        let realm = try! Realm()
        
        var predicate = NSPredicate(format: "franchise = %@", franchise.name)
        if inMyCollectionOnly {
            predicate = NSPredicate(format: "franchise = %@ AND inMyCollection = true", franchise.name)
        }
        
        return Array(realm.objects(Item.self).filter(predicate)).sorted(by: {$0.number < $1.number})
    }
    
    //MARK : - Franchises
    
    class func getAllFranchises() -> [Franchise] {
        let realm = try! Realm()
        return Array(realm.objects(Franchise.self))
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
}
