//
//  CustomUIExtensions.swift
//  TestApp
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public struct CustomUIExtensions {
    public static func textShadow() -> NSShadow{
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.Theme.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
    }
}

extension UIColor {
    func fromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }
}

extension UIColor {
  struct Theme {
    static var mainBlue = UIColor().fromRGBA(red: 20, green: 42, blue: 74, alpha: 1.0)
    static var red = UIColor().fromRGBA(red: 222, green: 46, blue: 65, alpha: 1.0)
    static var blue = UIColor().fromRGBA(red: 88, green: 160, blue: 220, alpha: 1.0)
    static var darkBlue = UIColor().fromRGBA(red: 0, green: 37, blue: 99, alpha: 1.0)
    static var white = UIColor().fromRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)
    static var green = UIColor().fromRGBA(red: 102, green: 191, blue: 147, alpha: 1.0)
    static var black = UIColor().fromRGBA(red: 0, green: 0, blue: 0, alpha: 1.0)
    static var grey = UIColor().fromRGBA(red: 205, green: 199, blue: 190, alpha: 1.0)
    static var darkGrey = UIColor().fromRGBA(red: 158, green: 150, blue: 141, alpha: 1.0)
  }
}
