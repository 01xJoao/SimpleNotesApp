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
    private let _networking = Networking(baseURL : "http://ec2-52-56-38-215.eu-west-2.compute.amazonaws.com:8080/api/v1/")
    
    init(reportService: ReportService) {
        _reportService = reportService
    }
    
    func getRequest<T : Decodable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String {
        
        let requestId = _networking.get("\(requestUri)") { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func postRequest<T: Decodable>(requestUri: String, params: [String: Any], completion: @escaping (_ result: T?) -> Void) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        let requestId = _networking.post("\(requestUri)", parameters: jsonData) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func putRequest<T: Decodable>(requestUri: String, params: [String: Any], completion: @escaping (_ result: T?) -> Void) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        let requestId = _networking.put("\(requestUri)", parameters: jsonData) { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func deleteRequest<T: Decodable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String {
        let requestId = _networking.delete("\(requestUri)") { result in
            self._handleResult(result, completion)
        }
        
        return requestId
    }
    
    func _handleResult<T : Decodable>(_ result: JSONResult, _ completion: (_ result: T?) -> Void ) {
        switch result {
            
        case .success(let response):
            do {
                let res = try JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: response.dictionaryBody["data"]!))
                completion(res)
            } catch let error {
                _reportService.sendError(error: error, message: "Json serialization didn't worked for \(T.self) object with data \(response.dictionaryBody["data"]!)")
            }
        case .failure(let response):
            let errorCode = response.error.code
            print(errorCode)
            completion(nil)
        }
    }
}
