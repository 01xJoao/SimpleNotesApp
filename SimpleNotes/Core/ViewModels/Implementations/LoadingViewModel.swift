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
        let _: LoginViewModel? = navigationService.navigate(arguments: false, animated: true)
        print(l10nService.localize(key: "rt"))
    }
    
}
