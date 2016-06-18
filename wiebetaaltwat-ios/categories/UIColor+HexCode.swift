//
//  UIColor+HexCode.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 5/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(colorCode: String, alpha: Float = 1.0){
        let scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;

        scanner.scanHexInt(&color)

        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)

        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
}