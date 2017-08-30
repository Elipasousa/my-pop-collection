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
        f1.image = "https://goo.gl/jBX2k9"
        
        let f2 = Franchise()
        f2.name = "Futurama"
        f2.image = "https://goo.gl/jBX2k9"

        let f3 = Franchise()
        f3.name = "Game of Thrones"
        f3.image = "https://goo.gl/jBX2k9"

        let f4 = Franchise()
        f4.name = "Doraemon"
        f4.image = "https://goo.gl/jBX2k9"

        return [f1, f2, f3, f4]
    }
    
    func getItems(fromFranchise franchise: Franchise) -> [Item] {
        let p1 = Item()
        p1.name = "Harry Potter"
        p1.number = 01
        p1.image = "https://goo.gl/XTB35D"
        p1.paidPrice = 12.50
        p1.estimatedValue = 15.00
        p1.rarity = "Common"
        p1.franchise = "Harry Potter"
        p1.condition = "CIB"
        p1.itemState = "Mint"
        p1.boxState = "Mint"
        
        let p2 = Item()
        p2.name = "Hermione Granger"
        p2.number = 03
        p2.image = "https://goo.gl/4MCRrM"
        p2.paidPrice = 12.50
        p2.estimatedValue = 15.00
        p2.rarity = "Common"
        p2.franchise = "Harry Potter"
        p2.condition = "CIB"
        p2.itemState = "Mint"
        p2.boxState = "Mint"
        
        return [p1, p1, p2, p1, p2]
    }

}
