//
//  ServiceMock.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import CSV

class ServiceMock {
    
    static let sharedInstance: ServiceMock = ServiceMock()
    
    func parseItems(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let filePath = Bundle.main.path(forResource: "pops", ofType: "csv")!
            let stream = InputStream(fileAtPath: filePath)!
            let csv = try! CSVReader(stream: stream,
                                     hasHeaderRow: true)
            
            let headerRow = csv.headerRow!
            print("\(headerRow)")
            
            while let _ = csv.next() {
                //print("\(row)")
                if csv["category_name"]!.hasPrefix("Pop! Vinyl Pop!") {
                    let p = Item()
                    p.identifier = Int(csv["pop_id"]!)!
                    p.name = csv["name"]!
                    p.image = csv["image_url"]
                    p.franchiseId = Int(csv["franchise_id"]!)!
                    p.categoryId = Int(csv["category_id"]!)!
                    if let n = Int(csv["item_number"]!) {
                        p.number = n
                    } else {
                        p.number = -1
                    }
                    DatabaseHelper.addItem(p)
                }
            }
            completion()
        }
    }
    
    func parseFranchises(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let filePath = Bundle.main.path(forResource: "franchises", ofType: "csv")!
            let stream = InputStream(fileAtPath: filePath)!
            let csv = try! CSVReader(stream: stream,
                                     hasHeaderRow: true)
            
            let headerRow = csv.headerRow!
            print("\(headerRow)")
            
            while let _ = csv.next() {
                //print("\(row)")
                let f = Franchise()
                f.identifier = Int(csv["franchise_id"]!)!
                f.name = csv["name"]!
                f.image = csv["image_url"]
                DatabaseHelper.addFranchise(f)
            }
            completion()
        }
    }
    
    func parseCategories(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let filePath = Bundle.main.path(forResource: "categories", ofType: "csv")!
            let stream = InputStream(fileAtPath: filePath)!
            let csv = try! CSVReader(stream: stream,
                                     hasHeaderRow: true)
            
            let headerRow = csv.headerRow!
            print("\(headerRow)")
            
            while let _ = csv.next() {
                //print("\(row)")
                let c = Category()
                c.identifier = Int(csv["category_id"]!)!
                c.name = csv["name"]!
                DatabaseHelper.addCategory(c)
            }
            completion()
        }
    }
    
    /*func checkDoubles() {
        let franchises = DatabaseHelper.getFranchises(withSearch: nil)
        print("TOTAL FRACHISES: \(franchises.count)")
        var dif_f_c = 0
        
        for f in franchises {
            let items = DatabaseHelper.getItemsFromFranchise(fromFranchise: f, inMyCollectionOnly: false)
            
            var category_names: [String] = []
            for i in items {
                if !category_names.contains(i.category) {
                    category_names.append(i.category)
                }
            }
            if category_names.count > 1 {
                dif_f_c += 1
                print("\n" + f.name)
                for s in category_names {
                    print("\t" + s)
                }
            }
        }
        print("DIF FRACHISES: \(dif_f_c)")
    }*/
}
