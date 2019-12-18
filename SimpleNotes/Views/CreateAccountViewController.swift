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

public class CreateAccountViewController : FormBaseViewController<CreateAccountViewModel> {
    private let _signInButton = UIButton(title: "Create", titleColor: UIColor.Theme.white,
                                 font: .systemFont(ofSize: 16), backgroundColor: UIColor.Theme.mainBlue)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Account"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barStyle = .black
        _setupSignInButton()
    }
    
    private func _setupSignInButton(){
        self.view.addSubview(_signInButton)
        _signInButton.translatesAutoresizingMaskIntoConstraints = false
        _signInButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        _signInButton.constrainHeight(50 + (Utils().keyWindow?.safeAreaInsets.bottom)!)
    }
    
    override public  func viewSafeAreaInsetsDidChange() {
        _setupSignInButton()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
