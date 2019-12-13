//
//  NavigationServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public protocol NavigationServiceProtocol {
    func visibleViewController() -> UIViewController
    
    func navigate<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type,  arguments: Any?, animated: Bool)
    func navigateModal<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type,arguments: Any?)
    func navigateAndSetAsContainer<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type)
    
    func close(arguments: Any?, animated: Bool);
    func closeModal(arguments: Any?);
}
