//
//  ViewModelBase.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class ViewModelBase : ViewModelProtocol {
    private let _navigationService: NavigationServiceProtocol = Container.resolve()
    
    public var navigationService: NavigationServiceProtocol {
        get {
            return _navigationService
        }
    }
    
    private var _isBusy = false
    public var isBusy : Bool {
        get {
            return _isBusy
        }
        set {
            _isBusy = newValue
            //Add notify
        }
    }
    
    public func initialize(){
        print("initialized")
    }
    
    public func appearing(){
        print("appearing")
    }
    
    public func appeared(){
        print("appeared")
    }
    
    public func disappearing(){
        print("disappearing")
    }
}
