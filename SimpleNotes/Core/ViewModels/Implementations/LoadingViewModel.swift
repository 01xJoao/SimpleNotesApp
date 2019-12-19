//
//  LoadingViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoadingViewModel : ViewModelBase {
    let appSettingsService: AppSettingsService
    
    init(appSettingsService: AppSettingsService) {
        self.appSettingsService = appSettingsService
    }
    
    public override func initialize() {
        _checkIfUserIsSignedIn()
    }
    
    private func _checkIfUserIsSignedIn() {
        if(appSettingsService.isUserLoggedIn) {
            navigationService.navigateAndSetAsContainer(viewModel: NotesListViewModel.self)
        } else {
            navigationService.navigateAndSetAsContainer(viewModel: LoginViewModel.self)
        }
    }
}
