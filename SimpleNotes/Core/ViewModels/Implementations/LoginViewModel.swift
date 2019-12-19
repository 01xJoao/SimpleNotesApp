//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBaseWithArguments<Bool> {
    private let userWebService: UserWebService
    private let dialogService: DialogService
    private let databaseUserService: DatabaseUserService
    private var appSettingsService: AppSettingsService
    
    public var email: DynamicValue<String> = DynamicValue<String>("")

    private var _navigateToCreateAccountCommand: Command?
    public var navigateToCreateAccountCommand: Command {
        get { _navigateToCreateAccountCommand ??= Command(_navigateTpCreateAccount, canExecute: _canExecute); return _navigateToCreateAccountCommand!}
    }
    
    private var _loginCommand: WpCommand<[String]>?
    public var loginCommand: WpCommand<[String]> {
        get { _loginCommand ??= WpCommand<[String]>(_login, canExecute: _canExecute); return _loginCommand!}
    }
    
    init(userWebService: UserWebService, dialogService: DialogService, databaseUserService: DatabaseUserService, appSettingsService: AppSettingsService) {
        self.userWebService = userWebService
        self.dialogService = dialogService
        self.databaseUserService = databaseUserService
        self.appSettingsService = appSettingsService
    }
    
    private func _navigateTpCreateAccount() {
        navigationService.navigate(viewModel: CreateAccountViewModel.self, arguments: nil, animated: true)
    }
    
    private func _login(_ parameters: [String]) {
        if(_verifyForm(parameters)) {
            let user = User(UserObject(name: "", email: parameters[0], password: parameters[1]))
            _ = userWebService.login(user: user) { userObj in self._loginCompletion(userObj) }
        }
    }
    
    private func _verifyForm(_ userString: [String]) -> Bool {
        if (userString.contains("")) {
            _sendAlert("Please enter your email and password.", .bad)
            return false
        } else if (!Utils.isValidEmail(userString[0])) {
            _sendAlert("Invalid email", .bad)
            return false
        }
        return true
    }
    
    private func _loginCompletion(_ userObject: UserObject?) {
        if(userObject != nil) {
            _saveUserInformation(userObject!)
            navigationService.navigateAndSetAsContainer(viewModel: NotesListViewModel.self)
            dialogService.showInfo("Signed in successfully!", informationType: .good)
        }
    }
    
    private func _saveUserInformation(_ userObj: UserObject) {
        let user = User(userObj)
        databaseUserService.createUser(user)
        
        appSettingsService.isUserLoggedIn = true
        appSettingsService.userEmail = user.getEmail()
    }
    
    private func _sendAlert(_ alertMessage: String, _ alertType: InfoDialogType){
        dialogService.showInfo(alertMessage, informationType: alertType)
    }
    
    public override func dataNotify(dataObject: Any?) {
        if (dataObject != nil) {
            email.value = dataObject as! String
        }
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
