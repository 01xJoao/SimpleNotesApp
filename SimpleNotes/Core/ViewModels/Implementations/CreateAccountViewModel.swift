//
//  CreateAccountViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class CreateAccountViewModel : ViewModelBase {
    private let userWebService: UserWebService
    private let dialogService: DialogService
    private let appSettingsService: AppSettingsService
    
    private var user: User?
    
    private var _createAccountCommand: WpCommand<[String]>?
    public var createAccountCommand: WpCommand<[String]> {
        get { _createAccountCommand ??= WpCommand<[String]>(_createUserAccount, canExecute: _canExecute); return _createAccountCommand!}
    }
    
    init(userWebService: UserWebService, dialogService: DialogService, appSettingsService: AppSettingsService) {
        self.userWebService = userWebService
        self.dialogService = dialogService
        self.appSettingsService = appSettingsService
    }
    
    public override func initialize() {
        _configureLocalization()
    }
    
    private func _createUserAccount(userString: [String]) {
        if (_verifyUserForm(userString)) {
            _createUser(userString)
            dialogService.startLoading()
            _ = userWebService.createUser(user: user!) { userObj in self._createUserCompletion(userObj) }
        }
    }
    
    private func _verifyUserForm(_ userString: [String]) -> Bool {
        if (userString.contains("")) {
            _sendAlert(completeFormText, .bad)
            return false
        } else if (!Utils.isValidEmail(userString[1])) {
            _sendAlert(invalidEmailText, .bad)
            return false
        } else if (userString[2] != userString[3]) {
            _sendAlert(passwordsDontMatchText, .bad)
            return false
        }
        return true
    }
    
    private func _createUser(_ userString: [String]) {
        let userPushNotificationId = appSettingsService.userNotificationId
        let userObj = UserObject(name: userString[0], email: userString[1], password: userString[2], pushNotificationId: userPushNotificationId)
        user = User(userObj)
    }
    
    private func _createUserCompletion(_ userObj: UserObject?) {
        dialogService.stopLoading()
        if (userObj != nil) {
            _sendAlert(userCreatedText, .good)
            navigationService.close(arguments: userObj?.email, animated: true)
        } else {
            _sendAlert(somethigWrongText, .bad)
        }
    }
    
    private func _sendAlert(_ alertMessage: String, _ alertType: InfoDialogType){
        dialogService.showInfo(alertMessage, informationType: alertType)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    public var nameText: String!
    public var emailText: String!
    public var passwordText: String!
    public var confirmPasswordText: String!
    public var createAccountText: String!
    
    private var invalidEmailText: String!
    private var completeFormText: String!
    private var passwordsDontMatchText: String!
    private var userCreatedText: String!
    private var somethigWrongText: String!
    
    private func _configureLocalization() {
        nameText = l10nService.localize(key: "create_name")
        emailText = l10nService.localize(key: "create_email")
        passwordText =  l10nService.localize(key: "create_password")
        confirmPasswordText = l10nService.localize(key: "create_cpassword")
        createAccountText =  l10nService.localize(key: "create_account")
        
        invalidEmailText = l10nService.localize(key: "dialog_invalidEmail")
        completeFormText =  l10nService.localize(key: "dialog_completeForm")
        passwordsDontMatchText = l10nService.localize(key: "dialog_matchPasswords")
        userCreatedText =  l10nService.localize(key: "dialog_userCreated")
        somethigWrongText = l10nService.localize(key: "dialog_somethingwrong")
    }
}
