//
//  Command.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public struct Command {
    private let action: () -> ()
    private let canExecuteAction: () -> (Bool)

    init(_ action: @escaping () -> (), canExecute: @escaping () -> (Bool) = {true}) {
        self.action = action
        self.canExecuteAction = canExecute
    }

    public func execute() {
        action()
    }
    
    public func executeIf() {
        if(canExecuteAction()) {
            action()
        }
    }
    
    public func canExecute() -> Bool {
        return canExecuteAction()
    }
}

public struct WpCommand<T> {
    private let actionWithParam: (T) -> ()
    private let canExecuteAction: () -> (Bool)

    init(_ actionWithParam: @escaping (T) -> (), canExecute: @escaping () -> (Bool) = {true}) {
        self.actionWithParam = actionWithParam
        self.canExecuteAction = canExecute
    }

    public func execute(_ value: T) {
        actionWithParam(value)
    }
    
    public func executeIf(_ value: T) {
        if(canExecuteAction()) {
           actionWithParam(value)
        }
    }
    
    public func canExecute() -> Bool {
        return canExecuteAction()
    }
}
