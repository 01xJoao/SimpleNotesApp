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
        DiContainer.registerAsSingleton(NavigationServiceProtocol.self) { NavigationServiceImp() }
        DiContainer.registerAsSingleton(DialogServiceProtocol.self) { DialogServiceImp(navigationService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(L10NServiceProtocol.self) { L10NServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(ReportServiceProtocol.self) { ReportServiceImp() }
        DiContainer.registerAsSingleton(AppSettingsServiceProtocol.self) { AppSettingsServiceImp() }
    }
    
    private static func _registerViewModels(){
        DiContainer.register(LoadingViewModel.self) { LoadingViewModel(appSettingsService: DiContainer.resolve()) }
        DiContainer.register(LoginViewModel.self) { LoginViewModel(dialogService: DiContainer.resolve()) }
        DiContainer.register(CreateAccountViewModel.self) { CreateAccountViewModel() }
    }
    
    private static func _registerViewControllers(){
        DiContainer.registerViewController(LoadingViewModel.self) { LoadingViewController() }
        DiContainer.registerViewController(LoginViewModel.self) { LoginViewController() }
        DiContainer.registerViewController(CreateAccountViewModel.self) { CreateAccountViewController() }
    }
    
    public static func startApp(){
        let navigationService : NavigationServiceProtocol = DiContainer.resolve()
        let _: LoadingViewModel? = navigationService.navigateAndSetAsContainer()
    }
}
