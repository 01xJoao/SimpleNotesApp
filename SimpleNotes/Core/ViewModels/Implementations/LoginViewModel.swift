//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBaseWithArguments<Bool> {

    private var _navigateToCreateAccountCommand: Command?
    public var navigateToCreateAccountCommand: Command {
        get { _navigateToCreateAccountCommand ??= Command(_navigateTpCreateAccount, canExecute: _canExecute); return _navigateToCreateAccountCommand!}
    }
    
    private func _navigateTpCreateAccount() {
        navigationService.navigate(viewModel: CreateAccountViewModel.self, arguments: nil, animated: true)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
