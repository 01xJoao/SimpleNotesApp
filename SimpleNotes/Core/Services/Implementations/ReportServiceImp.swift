//
//  ReportServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 12/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import Sentry

class ReportServiceImp : ReportService {
    
    func sendError(error: Error, message: String?) {
        Sentry.Client.shared?.snapshotStacktrace {
            let nsError = error as NSError
            let exception = self._createException(nsError)
            let event = self._createErrorEvent(nsError, exception, message)

            Sentry.Client.shared?.appendStacktrace(to: event)
            Sentry.Client.shared?.send(event: event, completion: nil)
        }
    }
    
    private func _createException(_ nsError: NSError) -> Exception {
        let exception = Sentry.Exception(
            value: "\(nsError.domain).\(nsError.code)",
            type: nsError.domain
        )
        exception.thread?.crashed = 0
        
        return exception
    }
    
    private func _createErrorEvent(_ nsError: NSError, _ exception: Exception, _ message: String?) -> Event {
        let event = Sentry.Event(level: .error)
        event.logger = "****.Logger"
        event.exceptions = [exception]
        event.message = message ?? ""
        event.extra = [
            "error_description": nsError.description,
            "error_localized_description": nsError.localizedDescription,
        ]
        
        return event
    }
    
    func sendEvent(message: String) {
        let event = Event(level: .info)
        event.message = message
        Client.shared?.send(event: event)
    }
}
