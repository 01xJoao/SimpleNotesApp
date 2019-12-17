//
//  DynamicValue.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class DynamicValue<T> {
    private var _observers = [String: CompletionHandler]()
    
    public var value : T {
        didSet {
            self._notify()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        _observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self._notify()
    }
    
    private func _notify() {
        _observers.forEach({ $0.value() })
    }
    
    deinit {
        _observers.removeAll()
    }
}
