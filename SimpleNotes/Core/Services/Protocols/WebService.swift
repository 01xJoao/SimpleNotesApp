//
//  WebService.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol WebService {
    func getRequest<T>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
    func postRequest(requestUri: String, params: [String: Any], completion: @escaping (_ result: Any?) -> Void) -> String
    func putRequest(requestUri: String, params: [String: Any], completion: @escaping (_ result: Any?) -> Void) -> String
    func deleteRequest(requestUri: String, completion: @escaping (_ result: Any?) -> Void) -> String
}
