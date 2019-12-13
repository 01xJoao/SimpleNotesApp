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
        DiContainer.registerAsSingleton(NavigationService.self) { NavigationServiceImp() }
        DiContainer.registerAsSingleton(DialogService.self) { DialogServiceImp(navigationService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(L10NService.self) { L10NServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerAsSingleton(ReportService.self) { ReportServiceImp() }
        DiContainer.registerAsSingleton(AppSettingsService.self) { AppSettingsServiceImp() }
        DiContainer.registerAsSingleton(LocationService.self) { LocationServiceImp() }
    }
    
    private static func _registerViewModels(){
        DiContainer.register(LoadingViewModel.self) { LoadingViewModel() }
        DiContainer.register(LoginViewModel.self) { LoginViewModel() }
        DiContainer.register(CreateAccountViewModel.self) { CreateAccountViewModel() }
    }
    
    private static func _registerViewControllers(){
        DiContainer.registerViewController(LoadingViewModel.self) { LoadingViewController() }
        DiContainer.registerViewController(LoginViewModel.self) { LoginViewController() }
        DiContainer.registerViewController(CreateAccountViewModel.self) { CreateAccountViewController() }
    }
    
    public static func startApp(){
        let navigationService : NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: LoadingViewModel.self)
    }
}
