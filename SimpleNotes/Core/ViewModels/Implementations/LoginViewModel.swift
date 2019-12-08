//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBase {

    public func navigateBackCommand(){
        navigationService.close(animated: true)
    }
    
    public func navigateToCreateAccountCommand(){
        let _: CreateAccountViewModel? = navigationService.navigateModal()
    }
}
