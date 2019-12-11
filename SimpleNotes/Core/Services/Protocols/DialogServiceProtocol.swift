//
//  DialogServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol DialogServiceProtocol {
    func showInfo(_ description: String, informationType: InfoDialogType)
}
