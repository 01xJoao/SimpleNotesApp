//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBaseWithArguments<Bool> {

    private var _createAccountCommand: Command?
    public var createAccountCommand: Command {
        get { _createAccountCommand ??= Command(_createAccount, canExecute: _canExecute); return _createAccountCommand!}
    }
    
    private func _createAccount() {
        navigationService.navigate(viewModel: CreateAccountViewModel.self, arguments: nil, animated: true)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
