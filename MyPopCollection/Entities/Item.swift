//
//  Item.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation

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

class Item {
    
    var name: String?
    var number: Int?
    var paidPrice: Double?
    var estimatedValue: Double?
    var dateBought: Date?
    var quantity: Int?
    var rarity: Rarity?
    var description: String?
    var franchise: Franchise?
    var collection: MyCollection?
    var condition: Condition?
    var itemState: State?
    var boxState: State?

    init() {}
}
