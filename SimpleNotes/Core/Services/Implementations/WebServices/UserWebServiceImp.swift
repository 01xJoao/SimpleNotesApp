//
//  UserWebServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class UserWebServiceImp : UserWebService {
    private let _webService: WebService
    
    init(webService: WebService) {
        self._webService = webService
    }
    
    func login(user: User, completion: @escaping (UserObject?) -> Void) -> String {
        let cancelationToken = _webService.postRequest(requestUri: "user/login", params: user.serialize()) { user in completion(user) }
        return cancelationToken
    }
    
    func getUser(userId: Int16, completion: @escaping (_ user: UserObject?) -> Void) -> String {
        let cancelationToken = _webService.getRequest(requestUri: "user/\(userId)") { user in completion(user) }
        return cancelationToken
    }
    
    func getAllUsers(completion: @escaping (_ user: [UserObject]?) -> Void) -> String {
        let cancelationToken = _webService.getRequest(requestUri: "user") { users in completion(users) }
        return cancelationToken
    }
    
    func createUser(user: User, completion: @escaping (UserObject?) -> Void) -> String {
        let cancelationToken = _webService.postRequest(requestUri: "user", params: user.serialize()) { user in completion(user) }
        return cancelationToken
    }
    
    func updateUser(user: User, completion: @escaping (UserObject?) -> Void) -> String {
        let cancelationToken = _webService.putRequest(requestUri: "user", params: user.serialize()) { user in completion(user) }
        return cancelationToken
    }
    
    func deleteUser(userId: Int16, completion: @escaping (UserObject?) -> Void) -> String {
        let cancelationToken = _webService.deleteRequest(requestUri: "user/\(userId)") { user in completion(user) }
        return cancelationToken
    }
    
    func cancelRequest(id: String){
        _webService.cancelRequest(id)
    }
}
