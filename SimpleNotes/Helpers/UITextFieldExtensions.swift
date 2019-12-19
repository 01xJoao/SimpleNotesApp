//
//  UITextFieldExtensions.swift
//  SimpleNotes
//
//  Created by João Palma on 18/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public struct UITextFieldExtensions {
    
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
    
    public static func changeFormColors(_ line: UIView, _ label: UILabel, _ color: UIColor) {
        line.backgroundColor = color
        label.textColor = color
    }
    
    public static func animateIndicatorText(_ textField: UITextField, _ string: String, _ label: UILabel) {
         UIView.animate(withDuration: 0.3) { label.alpha = string == "" && textField.text?.count == 1 ? 0 : 1 }
    }
    
    public static func animateFormOnFinishEditing(_ textField: UITextField, _ label: UILabel, _ line: UIView, _ color: UIColor){
        changeFormColors(line, label, color)
        UIView.animate(withDuration: 0.3) { label.alpha = textField.text!.isEmpty ? 0 : 1 }
    }
}
