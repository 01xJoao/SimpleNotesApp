//
//  WebService.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol WebService {
    func getRequest<T : Codable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
    func postRequest<T : Codable>(requestUri: String, params: Any, completion: @escaping (_ result: T?) -> Void) -> String
    func putRequest<T : Codable>(requestUri: String, params: Any, completion: @escaping (_ result: T?) -> Void) -> String
    func deleteRequest<T : Codable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
    func cancelRequest(_ id: String)
}
