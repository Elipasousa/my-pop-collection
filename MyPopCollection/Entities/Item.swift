//
//  Item.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import RealmSwift

enum Condition {
    case CIB
    case BoxOnly
    case PopOnly
}

enum State {
    case Mint
    case NearMint
    case Good
    case SlightlyDamaged
    case VeryDamaged
}

enum Rarity {
    case VeryRare
    case Rare
    case Uncommon
    case Common
}

class Item : Object {
    
    dynamic var name: String = ""
    dynamic var number: Int = 0
    dynamic var image: String?
    dynamic var paidPrice: Double = 0.0
    dynamic var estimatedValue: Double = 0.0
    dynamic var dateBought: Date?
    dynamic var quantity: Int = 1
    dynamic var rarity: String = "Common"
    dynamic var franchise: String?
    dynamic var collection: String?
    dynamic var condition: String = "CIB"
    dynamic var itemState: String = "Mint"
    dynamic var boxState: String = "Mint"
}
