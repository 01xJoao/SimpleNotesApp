//
//  WebService.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol WebService {
    func getRequest<T : Decodable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
    func postRequest<T : Decodable>(requestUri: String, params: [String: Any], completion: @escaping (_ result: T?) -> Void) -> String
    func putRequest<T : Decodable>(requestUri: String, params: [String: Any], completion: @escaping (_ result: T?) -> Void) -> String
    func deleteRequest<T : Decodable>(requestUri: String, completion: @escaping (_ result: T?) -> Void) -> String
}
