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
    
    private func _createUserAccount(userString: [String]) {
        if (_verifyUserForm(userString)) {
            _createUser(userString)
            _ = userWebService.createUser(user: user!) { userObj in self._createUserCompletion(userObj) }
        }
    }
    
    private func _verifyUserForm(_ userString: [String]) -> Bool {
        if (userString.contains("")) {
            _sendAlert("Please complete the form.", .bad)
            return false
        } else if (!Utils.isValidEmail(userString[1])) {
            _sendAlert("Invalid email", .bad)
            return false
        } else if (userString[2] != userString[3]) {
            _sendAlert("Passwords doesn't match.", .bad)
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
        if (userObj != nil) {
            _sendAlert("User created succefully! Please sign in", .good)
            navigationService.close(arguments: userObj?.email, animated: true)
        } else {
            _sendAlert("Something went wrong. \nPlease check your form.", .bad)
        }
    }
    
    private func _sendAlert(_ alertMessage: String, _ alertType: InfoDialogType){
        dialogService.showInfo(alertMessage, informationType: alertType)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
