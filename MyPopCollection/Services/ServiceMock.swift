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
                
                if csv["category"]!.hasPrefix("Pop! Vinyl Pop!") {
                    let p = Item()
                    p.name = csv["name"]!
                    p.image = csv["image_url"]
                    p.franchise = csv["franchise"]!
                    p.category = csv["category"]!
                    if let n = Int(csv["item_number"]!) {
                        p.number = n
                    } else {
                        p.number = -1
                    }
                    
                    let f = Franchise()
                    f.name = csv["franchise"]!
                    
                    let c = Category()
                    c.name = csv["category"]!
                    
                    DatabaseHelper.addFranchise(f)
                    DatabaseHelper.addCategory(c)
                    DatabaseHelper.addItem(p)
                    
                    /*print("\(csv["name"])")
                     print("\(csv["franchise"])")
                     print("\(csv["category"])")
                     print("\(csv["price"])")
                     print("\(csv["item_number"])")
                     print("\(csv["image_url"])")
                     print("\(csv["release_date"])")
                     print("----------------------")*/
                    
                }
            }
            completion()
        }
    }
    
    func checkDoubles() {
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
    }
}
