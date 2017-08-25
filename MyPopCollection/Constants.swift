//
//  Constants.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import UIKit

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

let conditions = ["CIB", "Box Only", "Pop Only"]

let states = ["Mint", "Near Mint", "Good", "Slighthtly Damaged", "Very Damaged"]

let rarities = ["Very Rare", "Rare", "Uncommon", "Common"]
