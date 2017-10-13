//
//  Constants.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import UIKit

enum Condition : String {
    case CIB = "CIB"
    case BoxOnly = "BoxOnly"
    case PopOnly = "PopOnly"
}

enum State : String {
    case Mint = "Mint"
    case NearMint = "NearMint"
    case Good = "Good"
    case SlightlyDamaged = "SlightlyDamaged"
    case VeryDamaged = "VeryDamaged"
    case NA = "N/A"
}

enum Rarity : String {
    case VeryRare = "VeryRare"
    case Rare = "Rare"
    case Uncommon = "Uncommon"
    case Common = "Common"
}

let conditions: [String] = [Condition.CIB.rawValue, Condition.BoxOnly.rawValue, Condition.PopOnly.rawValue]

let states: [String] = [State.Mint.rawValue, State.NearMint.rawValue, State.Good.rawValue, State.SlightlyDamaged.rawValue, State.VeryDamaged.rawValue, State.NA.rawValue]

let rarities: [String] = [Rarity.VeryRare.rawValue, Rarity.Rare.rawValue, Rarity.Uncommon.rawValue, Rarity.Common.rawValue]

struct Colors {
    static let normalYellow = UIColor(hex: 0xF2B742, alpha: 1.0)
    static let lightGray = UIColor.lightGray
    static let darkGray = UIColor.darkGray
    static let clearGray = UIColor.lightGray.withAlphaComponent(0.2)
    static let normalRed = UIColor(hex: 0xBF6361, alpha: 1.0)
}

struct HUDTime {
    static let success = TimeInterval(0.4)
}

struct DefaultsKey {
    static let dontShowAgainPopupMultipleSelection = "dontShowAgainPopupMultipleSelection"
}
