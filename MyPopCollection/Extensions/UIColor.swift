//
//  UIColor.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 30/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexRed: Int, hexGreen: Int, hexBlue: Int, alpha: CGFloat) {
        assert(hexRed >= 0 && hexRed <= 255, "Invalid red component")
        assert(hexGreen >= 0 && hexGreen <= 255, "Invalid green component")
        assert(hexBlue >= 0 && hexBlue <= 255, "Invalid blue component")
        assert(alpha >= 0.0 && alpha <= 1.0, "Invalid alpha component")
        
        self.init(red: CGFloat(hexRed)/255.0, green: CGFloat(hexGreen)/255.0, blue: CGFloat(hexBlue)/255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        self.init(hexRed: (hex >> 16) & 0xff, hexGreen: (hex >> 8) & 0xff, hexBlue: hex & 0xff, alpha: alpha)
    }
}
