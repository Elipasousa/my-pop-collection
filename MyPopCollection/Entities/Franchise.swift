//
//  Franchise.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import RealmSwift

class Franchise : Object {

    dynamic var identifier: Int = 0
    dynamic var name: String = ""
    dynamic var image: String?
    dynamic var itemsInMyCollection: Int = 0
}
