//
//  L10NServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 11/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public protocol L10NServiceProtocol {
    func localize(key: String) -> String
    func getCurrentLanguage() -> String
}
