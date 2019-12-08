//
//  ViewModelBase.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class ViewModelBase : ViewModelProtocol {

    private let _navigationService: NavigationServiceProtocol = DiContainer.resolve()
    
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
    
    public func prepare(dataObject: Any) {}
    
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
    
    public func dismissChildViewNotify(dataObject: Any?) {
        print("dismissNotify \(String(describing: dataObject))")
    }
}

public class ViewModelBaseWithArguments<TObject> : ViewModelBase {
    public override func prepare(dataObject: Any) {
        prepare(data: dataObject as! TObject)
    }
    
    public func prepare(data: TObject) {}
}
