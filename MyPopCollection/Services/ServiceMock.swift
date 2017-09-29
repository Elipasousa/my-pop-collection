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
    
    func parseItems() {
        let filePath = Bundle.main.path(forResource: "pops", ofType: "csv")!
        let stream = InputStream(fileAtPath: filePath)!
        let csv = try! CSVReader(stream: stream,
                                 hasHeaderRow: true)
        
        let headerRow = csv.headerRow!
        print("\(headerRow)")
        
        while let row = csv.next() {
            print("\(row)")

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
            
            DatabaseHelper.addFranchise(f)
            DatabaseHelper.addItem(p)
            
            
            /*print("\(csv["name"])")
            print("\(csv["franchise"])")
            print("\(csv["category"])")
            print("\(csv["price"])")
             print("\(csv["item_number"])")
            print("\(csv["image_url"])")
            print("\(csv["release_date"])")
            print("-------------------------------------------")*/
        }
    }
}
