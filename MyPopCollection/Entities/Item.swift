//
//  Item.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    dynamic var name: String = ""
    dynamic var number: Int = 0
    dynamic var image: String?
    dynamic var franchise: String = ""
    // --- from my collection ---
    dynamic var paidPrice: Double = 0.0
    dynamic var estimatedValue: Double = 0.0
    dynamic var dateBought: Date = Date()
    dynamic var rarity: String = Rarity.Common.rawValue
    dynamic var condition: String = Condition.CIB.rawValue
    dynamic var itemState: String = State.Mint.rawValue
    dynamic var boxState: String = State.Mint.rawValue
    dynamic var inMyCollection: Bool = false
}
