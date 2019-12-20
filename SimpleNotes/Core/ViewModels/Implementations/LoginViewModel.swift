//
//  LoginViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoginViewModel: ViewModelBase {
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
    
    public override func initialize() {
        _configureLocalization()
    }
    
    private func _navigateTpCreateAccount() {
        navigationService.navigate(viewModel: CreateAccountViewModel.self, arguments: nil, animated: true)
    }
    
    private func _login(_ parameters: [String]) {
        if(_verifyForm(parameters)) {
            dialogService.startLoading()
            let user = User(UserObject(name: "", email: parameters[0], password: parameters[1]))
            _ = userWebService.login(user: user) { userObj in self._loginCompletion(userObj) }
        }
    }
    
    private func _verifyForm(_ userString: [String]) -> Bool {
        if (userString.contains("")) {
            _sendAlert(enterEmailandPassText, .bad)
            return false
        } else if (!Utils.isValidEmail(userString[0])) {
            _sendAlert(invalidEmailText, .bad)
            return false
        }
        return true
    }
    
    private func _loginCompletion(_ userObject: UserObject?) {
        dialogService.stopLoading()
        
        if(userObject != nil) {
            _saveUserInformation(userObject!)
            navigationService.navigateAndSetAsContainer(viewModel: NotesListViewModel.self)
            dialogService.showInfo(signedInText, informationType: .good)
        } else {
            _sendAlert(somethigWrongText, .bad)
        }
    }
    
    private func _saveUserInformation(_ userObj: UserObject) {
        let user = User(userObj)
        databaseUserService.createUser(user)
        
        appSettingsService.isUserSignedIn = true
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
    
    public var signinText: String!
    public var firstTimeText: String!
    public var emailText: String!
    public var passwordText: String!
    
    private var invalidEmailText: String!
    private var somethigWrongText: String!
    private var signedInText: String!
    private var enterEmailandPassText: String!
    
    private func _configureLocalization() {
        signinText = l10nService.localize(key: "login_signin")
        firstTimeText = l10nService.localize(key: "login_firstTime")
        emailText = l10nService.localize(key: "login_email")
        passwordText =  l10nService.localize(key: "login_password")
        
        signedInText = l10nService.localize(key: "dialog_signed")
        invalidEmailText = l10nService.localize(key: "dialog_invalidEmail")
        somethigWrongText = l10nService.localize(key: "dialog_somethingwrong")
        enterEmailandPassText = l10nService.localize(key: "dialog_enterEmailandPass")
    }
}
