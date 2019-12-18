//
//  UITextFieldExtensions.swift
//  SimpleNotes
//
//  Created by João Palma on 18/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class UITextFieldExtensions {
    
    public static func setupField(indicatorText: String, indicatorLabel: UILabel,
                                  textField: UITextField, divider: UIView, returnKeyType: UIReturnKeyType,
                                  activeColor: UIColor, inactiveColor: UIColor){
        
        textField.returnKeyType = returnKeyType
        textField.placeholder = indicatorText
        indicatorLabel.text = indicatorText
        indicatorLabel.alpha = textField.text!.isEmpty ? 0 : 1
        indicatorLabel.textColor = inactiveColor
        divider.backgroundColor = textField.text!.isEmpty ? inactiveColor : activeColor
        
        textField.attributedPlaceholder = NSAttributedString(string: indicatorText, attributes: [
            NSAttributedString.Key.foregroundColor: inactiveColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
    
    }
}
