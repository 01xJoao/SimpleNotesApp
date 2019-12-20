//
//  CreateAccountViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

class CreateAccountViewController : FormBaseViewController<CreateAccountViewModel>, UITextFieldDelegate {
    
    private let _imageView = UIImageView(image: #imageLiteral(resourceName: "logo_blue_3"), contentMode: .scaleAspectFit)
    
    private let _signUpButton = UIButton(title: "", titleColor: UIColor.Theme.white,
                                 font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.darkBlue)
    
    private let _nameIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _nameTextField = IndentedTextField(keyboardType: .default)
    private let _nameLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    private let _emailIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _emailTextField = IndentedTextField(keyboardType: .emailAddress)
    private let _emailLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    private let _passwordIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _passwordTextField = IndentedTextField(isSecureTextEntry: true)
    private let _passwordLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    private let _confirmPasswordIndicatorLabel = UILabel(text: "", font: .systemFont(ofSize: 11), textColor: UIColor.Theme.white)
    private let _confirmPasswordTextField = IndentedTextField(isSecureTextEntry: true)
    private let _confirmPasswordLineView = UIView(backgroundColor: UIColor.Theme.darkGrey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
    
    private func _setupView() {
        bottomButtonHeight = 50
        
        _setUpL10NTexts()
        _setupViewSizes()
        _setupCreateButton()
        _setupTextFields()
        _addViewsToFormStackContainer()
        
        viewAlignment = .top
        self.title = viewModel.createAccountText
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_handleTapDismiss)))
    }
    
    private func _setUpL10NTexts() {
        _signUpButton.setTitle(viewModel.createText, for: .normal)
        _nameIndicatorLabel.text = viewModel.nameText
        _emailIndicatorLabel.text = viewModel.emailText
        _passwordIndicatorLabel.text = viewModel.passwordText
        _confirmPasswordIndicatorLabel.text = viewModel.confirmPasswordText
    }
    
    private func _setupViewSizes() {
        _imageView.constrainHeight(27.5)
        
        [ _nameLineView,
          _emailLineView,
          _passwordLineView,
          _confirmPasswordLineView ].forEach{$0.constrainHeight(1)}
     }
    
    private func _setupCreateButton() {
        self.view.addSubview(_signUpButton)
        _signUpButton.translatesAutoresizingMaskIntoConstraints = false
        _signUpButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        _signUpButton.constrainHeight(bottomButtonHeight + (Utils().keyWindow.safeAreaInsets.bottom))
        _signUpButton.addTarget(self, action: #selector(_createAccountClick), for: UIControl.Event.touchUpInside)
    }
    
    private func _setupTextFields() {
        _nameTextField.tag = 0
        _emailTextField.tag = 1
        _passwordTextField.tag = 2
        _confirmPasswordTextField.tag = 3
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.nameText, indicatorLabel: _nameIndicatorLabel,
            textField: _nameTextField, divider: _nameLineView, returnKeyType: .next,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.emailText, indicatorLabel: _emailIndicatorLabel,
            textField: _emailTextField, divider: _emailLineView, returnKeyType: .next,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.passwordText, indicatorLabel: _passwordIndicatorLabel,
            textField: _passwordTextField, divider: _passwordLineView, returnKeyType: .next,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        UITextFieldExtensions.setupField(
            indicatorText: viewModel.confirmPasswordText, indicatorLabel: _confirmPasswordIndicatorLabel,
            textField: _confirmPasswordTextField, divider: _confirmPasswordLineView, returnKeyType: .done,
            activeColor: UIColor.Theme.darkBlue, inactiveColor: UIColor.Theme.darkGrey)
        
        [ _nameTextField,
          _emailTextField,
          _passwordTextField,
          _confirmPasswordTextField
        ].forEach {
            $0.delegate = self
            $0.textContentType = .oneTimeCode
            $0.autocorrectionType = .no
            $0.constrainHeight(32)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidLayoutSubviews()
    }
    
    private func _addViewsToFormStackContainer(){
        formContainerStackView.stack(
            UIView().stack(_imageView).padBottom(32.5),
            UIView().stack(_nameIndicatorLabel, _nameTextField, _nameLineView),
            UIView().stack(_emailIndicatorLabel, _emailTextField, _emailLineView),
            UIView().stack(_passwordIndicatorLabel, _passwordTextField, _passwordLineView),
            UIView().stack(_confirmPasswordIndicatorLabel, _confirmPasswordTextField, _confirmPasswordLineView),
            spacing: 16
        ).withMargins(.init(top: 40, left: 30, bottom: bottomButtonHeight + 30, right: 30))
    }
    
        public func textFieldDidBeginEditing(_ textField: UITextField) {
        let indicatorLabel = _getIndicatorLabel(textField)
        let lineView = _getLineView(textField)
        UITextFieldExtensions.changeFormColors(lineView, indicatorLabel, UIColor.Theme.darkBlue)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let indicatorLabel = _getIndicatorLabel(textField)
        UITextFieldExtensions.animateIndicatorText(textField, string, indicatorLabel)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let indicatorLabel = _getIndicatorLabel(textField)
        let lineView = _getLineView(textField)
        UITextFieldExtensions.animateFormOnFinishEditing(textField, indicatorLabel, lineView, UIColor.Theme.darkGrey)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1;
        let nextResponder = self.view.viewWithTag(nextTag);
        return nextResponder != nil ? nextResponder!.becomeFirstResponder() : textField.resignFirstResponder();
    }
    
    private func _getIndicatorLabel(_ textField: UITextField) -> UILabel {
        switch textField.tag {
        case 0:
            return _nameIndicatorLabel
        case 1:
            return _emailIndicatorLabel
        case 2:
            return _passwordIndicatorLabel
        case 3:
            return _confirmPasswordIndicatorLabel
        default:
            return _nameIndicatorLabel;
        }
    }
    
    private func _getLineView(_ textField: UITextField) -> UIView {
        switch textField.tag {
        case 0:
            return _nameLineView
        case 1:
            return _emailLineView
        case 2:
            return _passwordLineView
        case 3:
            return _confirmPasswordLineView
        default:
            return _nameLineView;
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc fileprivate func _createAccountClick() {
        self.viewModel.createAccountCommand.executeIf(
            [ _nameTextField.text!,
              _emailTextField.text!,
              _passwordTextField.text!,
              _confirmPasswordTextField.text! ]
        )
    }
    
    @objc fileprivate func _handleTapDismiss() {
        view.endEditing(true)
    }
}
