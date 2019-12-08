//
//  CreateAccountViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class CreateAccountViewModel : ViewModelBase {
    public func navigateBackCommand(){
        let _:LoginViewModel? = navigationService.navigateAndSetAsContainer()
    }
}
