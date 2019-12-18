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

public class LoginViewController : FormBaseViewController<LoginViewModel> {
    
    let _signInButton = UIButton(title: "Sign In", titleColor: UIColor.Theme.white,
                                 font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.mainBlue)
    let _signUpButton = UIButton(title: "First time around here? Sign Up!",
                                 titleColor: UIColor.Theme.darkBlue, font: .systemFont(ofSize: 14))
    
    let _imageView = UIImageView(image: #imageLiteral(resourceName: "logo_blue_2"), contentMode: .scaleAspectFit)
    
    let _emailIndicatorLabel = UILabel(text: "Email", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
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
        self.navigationController?.navigationBar.barStyle = .default
        self.view.addSubview(_signInButton)
        
        lowestElement = _passwordTextField
        
        _imageView.constrainHeight(74)
        _emailLineView.constrainHeight(1)
        _passwordLineView.constrainHeight(1)
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        
        _emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.darkGrey,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        _passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.darkGrey,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        [_emailTextField,
         _passwordTextField].forEach{$0.constrainHeight(32)}
        
        formContainerStackView.stack(
            UIView().stack(_imageView).padTop(20).padBottom(45),
            UIView().stack(_emailIndicatorLabel, _emailTextField, _emailLineView),
            UIView().stack(_passwordIndicatorLabel, _passwordTextField, _passwordLineView),
            UIView().stack(_signUpButton).padTop(35).padBottom(80),
            spacing: 16).withMargins(.init(top: 16, left: 30, bottom: 16, right: 30)
        )
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        _signInButton.translatesAutoresizingMaskIntoConstraints = false
        _signInButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        _signInButton.constrainHeight(50 + self.view.safeAreaInsets.bottom)
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
}
