//
//  CustomUIExtensions.swift
//  TestApp
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public class CustomUIExtensions {
    public static func textShadow() -> NSShadow{
        let textShadow = NSShadow()
        textShadow.shadowColor = AppColors.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
    }
}
