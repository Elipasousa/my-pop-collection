//
//  ServiceMock.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation

class ServiceMock {
    
    static let sharedInstance: ServiceMock = ServiceMock()
    
    func getAllFranchises() -> [Franchise] {
        let f1 = Franchise()
        f1.name = "Harry Potter"
        f1.image = "https://cdn.poppriceguide.com/guide/charimg/HarryPotter.jpg"
        
        let f2 = Franchise()
        f2.name = "Futurama"
        f2.image = "https://cdn.poppriceguide.com/guide/charimg/Futurama.jpg"

        let f3 = Franchise()
        f3.name = "Game of Thrones"
        f3.image = "https://cdn.poppriceguide.com/guide/charimg/GameofThrones.jpg"

        return [f1, f2, f3]
    }
    
    func getItems(fromFranchise franchise: Franchise) -> [Item] {
        var items: [Item] = []
        
        if franchise.name == "Harry Potter" {
            let p1 = Item()
            p1.name = "Harry Potter"
            p1.number = 1
            p1.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3698_harrypotter.jpg"
            p1.franchise = "Harry Potter"
            p1.category = "Pop Vinyl Pop Harry Potter"
            p1.paidPrice = 12.50
            p1.estimatedValue = 15.00
            
            let p2 = Item()
            p2.name = "Ron Weasley"
            p2.number = 2
            p2.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3700_ronweasley.jpg"
            p2.franchise = "Harry Potter"
            p2.category = "Pop Vinyl Pop Harry Potter"
            p2.paidPrice = 12.50
            p2.estimatedValue = 15.00
            
            let p3 = Item()
            p3.name = "Hermione Granger"
            p3.number = 3
            p3.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3702_hermionegranger.jpg"
            p3.franchise = "Harry Potter"
            p3.category = "Pop Vinyl Pop Harry Potter"
            p3.paidPrice = 12.50
            p3.estimatedValue = 15.00
            
            let p4 = Item()
            p4.name = "Ginny Weasley"
            p4.number = 46
            p4.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/11160_ginnyweasley_1503376459.jpg"
            p4.franchise = "Harry Potter"
            p4.category = "Pop Vinyl Pop Harry Potter"
            p4.paidPrice = 12.50
            p4.estimatedValue = 15.00
            
            items = [p1, p4, p2, p3]
        }
        return items
    }

}
