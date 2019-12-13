//
//  LoadingViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class LoadingViewModel : ViewModelBase {
    public func navigateToLoginCommand(){
        navigationService.navigate(viewModel: LoginViewModel.self, arguments: false, animated: true)
    }
}
