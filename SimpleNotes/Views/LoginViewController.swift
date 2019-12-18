//
//  LoginViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

public class LoginViewController : FormBaseViewController<LoginViewModel>, UITextFieldDelegate {
    
    let _signInButton = UIButton(title: "Sign In", titleColor: UIColor.Theme.white,
                                 font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.mainBlue)
    
    let _signInKeyboardButton = UIButton(title: "Sign In", titleColor: UIColor.Theme.white,
                                    font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.mainBlue)
    
    let _signUpButton = UIButton(title: "First time around here? Sign Up!",
                                 titleColor: UIColor.Theme.darkBlue, font: .systemFont(ofSize: 14))
    
    let _imageView = UIImageView(image: #imageLiteral(resourceName: "logo_blue_2"), contentMode: .scaleAspectFit)
    
    let _emailIndicatorLabel = UILabel(text: "Email address", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    let _emailTextField = IndentedTextField(keyboardType: .emailAddress)
    let _emailLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    let _passwordIndicatorLabel = UILabel(text: "Password", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    let _passwordTextField = IndentedTextField(isSecureTextEntry: true)
    let _passwordLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
                                 
    override public func viewDidLoad() {
        super.viewDidLoad()
        _setUpView()
    }

    private func _setUpView() {
        keyboardButtonHeight = 50
        _setupViewSizes()
        _setupTextFields()
        _addViewsToFormStackContainer()
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_handleTapDismiss)))
        self.navigationController?.navigationBar.barStyle = .default
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func _setupTextFields() {
        _emailTextField.tag = 0
        _passwordTextField.tag = 1
        
        UITextFieldExtensions.setupField(indicatorText: "Email address", indicatorLabel: _emailIndicatorLabel,
                                         textField: _emailTextField, divider: _emailLineView, returnKeyType: .next,
                                         activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        
        UITextFieldExtensions.setupField(indicatorText: "Password", indicatorLabel: _passwordIndicatorLabel,
                                        textField: _passwordTextField, divider: _passwordLineView, returnKeyType: .done,
                                        activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        _emailTextField.inputAccessoryView = _signInKeyboardButton
        _passwordTextField.inputAccessoryView = _signInKeyboardButton
        
        _emailTextField.delegate = self
        _passwordTextField.delegate = self
        
        _emailTextField.textContentType = .oneTimeCode
        _passwordTextField.textContentType = .oneTimeCode
        
        _emailTextField.autocorrectionType = .no
        _passwordTextField.textContentType = .oneTimeCode
    }
    
    func _setupViewSizes() {
        _imageView.constrainHeight(74)
        
        _signInKeyboardButton.constrainHeight(keyboardButtonHeight)

        [_emailLineView,
        _passwordLineView].forEach{$0.constrainHeight(1)}
                
        [_emailTextField,
         _passwordTextField].forEach{$0.constrainHeight(32)}
    }
    
    func _addViewsToFormStackContainer(){
        formContainerStackView.stack(
           UIView().stack(_imageView).padTop(20).padBottom(45),
           UIView().stack(_emailIndicatorLabel, _emailTextField, _emailLineView),
           UIView().stack(_passwordIndicatorLabel, _passwordTextField, _passwordLineView),
           UIView().stack(_signUpButton).padTop(35).padBottom(80),
           spacing: 16).withMargins(.init(top: 16, left: 30, bottom: 16, right: 30))
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _setupSignInButton()
    }
    
    private func _setupSignInButton(){
        self.view.addSubview(_signInButton)
        _signInButton.translatesAutoresizingMaskIntoConstraints = false
        _signInButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        _signInButton.constrainHeight(keyboardButtonHeight + self.view.safeAreaInsets.bottom)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            _emailLineView.backgroundColor = UIColor.Theme.darkBlue
            _emailIndicatorLabel.textColor = UIColor.Theme.darkBlue
        case 1:
            _passwordLineView.backgroundColor = UIColor.Theme.darkBlue
            _passwordIndicatorLabel.textColor = UIColor.Theme.darkBlue
        default:
            break;
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            _updateScrollViewSize(keyboardRectangle.height)
        }
    }
    
    func _updateScrollViewSize(_ keyboardHeight: CGFloat) {
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            UIView.animate(withDuration: 0.3) { self._emailIndicatorLabel.alpha = string == "" && textField.text?.count == 1 ? 0 : 1 }
        case 1:
            UIView.animate(withDuration: 0.3) { self._passwordIndicatorLabel.alpha = string == "" && textField.text?.count == 1 ? 0 : 1 }
        default:
            break;
        }
        return true
    }
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            _emailLineView.backgroundColor = UIColor.Theme.darkGrey
            _emailIndicatorLabel.textColor = UIColor.Theme.darkGrey
            UIView.animate(withDuration: 0.3) { self._emailIndicatorLabel.alpha = textField.text!.isEmpty ? 0 : 1 }
        case 1:
            _passwordLineView.backgroundColor = UIColor.Theme.darkGrey
            _passwordIndicatorLabel.textColor = UIColor.Theme.darkGrey
            UIView.animate(withDuration: 0.3) { self._passwordIndicatorLabel.alpha = textField.text!.isEmpty ? 0 : 1 }
        default:
            break;
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            _passwordTextField.becomeFirstResponder()
        case 1:
             _passwordTextField.resignFirstResponder()
        default:
            break;
        }
        return true
    }
    
    @objc fileprivate func _handleClickKeyboardButton() {
        view.endEditing(true)
    }
    
    @objc fileprivate func _handleTapDismiss() {
        view.endEditing(true)
    }
}
