//
//  Core.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public class Core {
    public static func initialize(){
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
    }
    
    private static func _registerServices(){
        Container.registerAsSingleton(NavigationServiceProtocol.self) { NavigationServiceImp() }
    }
    
    private static func _registerViewModels(){
        Container.register(LoadingViewModel.self) { LoadingViewModel() }
        Container.register(LoginViewModel.self) { LoginViewModel() }
        Container.register(CreateAccountViewModel.self) { CreateAccountViewModel() }
    }
    
    private static func _registerViewControllers(){
        Container.registerViewController(LoadingViewModel.self) { LoadingViewController() }
        Container.registerViewController(LoginViewModel.self) { LoginViewController() }
        Container.registerViewController(CreateAccountViewModel.self) { CreateAccountViewController() }
    }
    
    public static func startApp(){
        let navigationService : NavigationServiceProtocol = Container.resolve()
        let _: LoadingViewModel? = navigationService.navigateAndSetAsContainer()
    }
}
