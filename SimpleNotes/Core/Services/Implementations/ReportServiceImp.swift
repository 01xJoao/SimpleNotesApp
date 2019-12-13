//
//  ReportServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 12/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import Sentry

class ReportServiceImp : ReportServiceProtocol {
    
    func sendError(error: Error, message: String?) {
        Sentry.Client.shared?.snapshotStacktrace {
            let error = error as NSError

            let exception = Sentry.Exception(
                value: "\(error.domain).\(error.code)",
                type: error.domain
            )
            exception.thread?.crashed = 0

            let event = Sentry.Event(level: .error)
            event.logger = "****.Logger"
            event.exceptions = [exception]
            event.message = message ?? ""
            event.extra = [
                "error_description": error.description,
                "error_localized_description": error.localizedDescription,
            ]

            Sentry.Client.shared?.appendStacktrace(to: event)
            Sentry.Client.shared?.send(event: event, completion: nil)
        }
    }
    
    func sendEvent(message: String) {
        let event = Event(level: .info)
        event.message = message
        Client.shared?.send(event: event)
    }
}
