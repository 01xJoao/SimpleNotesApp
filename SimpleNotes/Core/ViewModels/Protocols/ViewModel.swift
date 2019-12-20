//
//  ViewModelProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

public protocol ViewModel {
    func prepare(dataObject: Any);
    func initialize()
    func appearing()
    func disappearing()
    func dataNotify(dataObject: Any?);
}
