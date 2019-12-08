//
//  NavigationServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public protocol NavigationServiceProtocol {
    func navigate<TViewModel : ViewModelProtocol>(animated: Bool) -> TViewModel?
    func navigateModal<TViewModel : ViewModelProtocol>() -> TViewModel?
    func navigateAndSetAsContainer<TViewModel : ViewModelProtocol>() -> TViewModel?
    
    func close(animated: Bool);
    func closeModal();
}
