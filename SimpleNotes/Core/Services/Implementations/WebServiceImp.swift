//
//  WebServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import Networking

class WebServiceImp : WebService {
    private let _reportService: ReportService
    private let _networking = Networking(baseURL : "http://simplenotes.com/api/")
    
    init(reportService: ReportService) {
        _reportService = reportService
    }
    
    func getRequest(requestUri: String, completion: @escaping (_ result: Any?) -> Void) -> String {
        
        let requestId = _networking.get("\(requestUri)") { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func postRequest(requestUri: String, params: [String: Any], completion: @escaping (_ result: Any?) -> Void) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        let requestId = _networking.post("\(requestUri)", parameters: jsonData) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func putRequest(requestUri: String, params: [String: Any], completion: @escaping (_ result: Any?) -> Void) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        let requestId = _networking.put("\(requestUri)", parameters: jsonData) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func deleteRequest(requestUri: String, completion: @escaping (_ result: Any?) -> Void) -> String {
        let requestId = _networking.delete("\(requestUri)") { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    
    func _handleResult(_ result: JSONResult, _ completion: (_ result: Any?) -> Void ) {
        switch result {
            
        case .success(let response):
            let res = response.arrayBody
            completion(res)
            
        case .failure(let response):
            let errorCode = response.error.code
            completion(errorCode)
        }
    }
}
