//
//  ColorUtils.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/30.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

extension UIColor {
    //hex:"#ffff0000"：red
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let a = Int(color >> 24) & mask
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let alpha = CGFloat(a) / 255.0
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

let halfTransparent = UIColor(hex: "#80000000")
let blue = UIColor(hex: "#ff0e65d7")
let lightBlue = UIColor(hex: "ff5d9cec")
let gray = UIColor(hex: "ffdcdcdc")
let lightGray = UIColor(hex: "#fff5f5f5")
