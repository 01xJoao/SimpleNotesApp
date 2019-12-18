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
    public static func SetupField(view: UIView, tag: Int, indicatorText: String, indicatorLabel: UILabel,
                                  textField: UITextField, divider: UIView, returnKeyType: UIReturnKeyType,
                                  keyboardView: UIView, activeColor: UIColor, inactiveColor: UIColor){
        textField.returnKeyType = returnKeyType
        textField.tag = tag
        textField.placeholder = indicatorText
        indicatorLabel.text = indicatorText
        indicatorLabel.alpha = textField.text!.isEmpty ? 0 : 1
        indicatorLabel.textColor = inactiveColor
        divider.backgroundColor = textField.text!.isEmpty ? inactiveColor : activeColor
        
        textField.attributedPlaceholder = NSAttributedString(string: indicatorText, attributes: [
            NSAttributedString.Key.foregroundColor: inactiveColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        textField.addTarget(self, action: #selector(_textFieldDidBegin(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(_textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(_textFieldDidEnd(_:)), for: .editingDidEnd)
    }
    
    @objc fileprivate func _textFieldDidBegin(_ textField: UITextField) {

    }
    
    @objc fileprivate func _textFieldDidChange(_ textField: UITextField) {

    }
    
    @objc fileprivate func _textFieldDidEnd(_ textField: UITextField) {

    }
}
