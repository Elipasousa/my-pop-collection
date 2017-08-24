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
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    class func getAllItems() -> [Item] {
        let realm = try! Realm()
        return Array(realm.objects(Item.self))
    }
    
    class func getAllItems(fromMyCollection collection: MyCollection) -> [Item] {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "collection = %@", collection.name)
        
        return Array(realm.objects(Item.self).filter(predicate))
    }
    
    //MARK : - Collections
    
    class func addMyCollection(_ collection: MyCollection) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(collection)
        }
    }

    class func getAllMyCollections() -> [MyCollection] {
        let realm = try! Realm()
        return Array(realm.objects(MyCollection.self))
    }

    class func existsCollection(withName name: String) -> Bool {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        return Array(realm.objects(MyCollection.self).filter(predicate)).count != 0
    }
    
    class func getCollection(withName name: String) -> MyCollection {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        return Array(realm.objects(MyCollection.self).filter(predicate)).first!
    }
}
