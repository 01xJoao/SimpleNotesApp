//
//  LoadingViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoadingViewModel : ViewModelBase {
    var _appSettingsService: AppSettingsServiceProtocol
    
    init(appSettingsService: AppSettingsServiceProtocol) {
        self._appSettingsService = appSettingsService
    }
    
    public func navigateToLoginCommand(){
        let _: LoginViewModel? = navigationService.navigate(arguments: false, animated: true)
    }
}
