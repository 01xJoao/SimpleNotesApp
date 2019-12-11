//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBaseWithArguments<Bool> {
    let _dialogService: DialogServiceProtocol
    
    private var _createAccountCommand: Command?
    public var createAccountCommand: Command {
        get { _createAccountCommand ??= Command(_createAccount, canExecute: _canExecute); return _createAccountCommand!}
    }
    
    init(dialogService: DialogServiceProtocol) {
        self._dialogService = dialogService
    }
    
    override public func prepare(data: Bool) {
    }
    
    private func _createAccount(){
        let _: CreateAccountViewModel? = navigationService.navigate(arguments: nil, animated: true)
    }
    
    public func navigateBackCommand(){
        _dialogService.showInfo("Test", informationType: InfoDialogType.good)
        navigationService.close(arguments: true, animated: true)
    }
    
    public func _canExecute() -> Bool {
        return !isBusy
    }
}
