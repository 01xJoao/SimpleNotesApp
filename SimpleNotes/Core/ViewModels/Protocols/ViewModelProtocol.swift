//
//  ViewModelProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public protocol ViewModelProtocol {
    func initialize()
    func appearing()
    func appeared()
    func disappearing()
}
