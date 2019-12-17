//
//  ViewModelBase.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class ViewModelBase : ViewModel {

    private let _navigationService: NavigationService = DiContainer.resolve()
    private let _l10nService: L10NService = DiContainer.resolve()
    
    public var navigationService: NavigationService {
        get {
            return _navigationService
        }
    }
    
    public var l10nService: L10NService {
        get {
            return _l10nService
        }
    }
    
    public var isBusy : DynamicValue<Bool> = DynamicValue<Bool>(false)
    
    public func prepare(dataObject: Any) {}
    
    public func initialize() {}
    
    public func appearing() {}
    
    public func appeared() {}
    
    public func disappearing() {}
    
    public func dismissChildViewNotify(dataObject: Any?) {}
}

public class ViewModelBaseWithArguments<TObject> : ViewModelBase {
    public override func prepare(dataObject: Any) {
        prepare(data: dataObject as! TObject)
    }
    
    public func prepare(data: TObject) {}
}
