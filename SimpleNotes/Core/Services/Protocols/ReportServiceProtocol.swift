//
//  ReportServiceProtocol.swift
//  SimpleNotes
//
//  Created by João Palma on 12/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol ReportServiceProtocol {
    func sendError(error: Error, message: String?)
    func sendEvent(message: String)
}
