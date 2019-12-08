//
//  NavigationServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public protocol NavigationServiceProtocol {
    func navigate<TViewModel : ViewModelProtocol>(arguments: Any?, animated: Bool) -> TViewModel?
    func navigateModal<TViewModel : ViewModelProtocol>(arguments: Any?) -> TViewModel?
    func navigateAndSetAsContainer<TViewModel : ViewModelProtocol>() -> TViewModel?
    
    func close(arguments: Any?, animated: Bool);
    func closeModal(arguments: Any?);
}
