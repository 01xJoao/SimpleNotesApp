//
//  UserWebServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class UserWebServiceImp {
    private let _webService: WebService
    
    init(webService: WebService) {
        self._webService = webService
    }
    
    func getUser<T>(userId: Int16, completion: @escaping (_ user: T?) -> Void){
        //_webService.getRequest(requestUri: "user/\(userId)") { user in completion(user as! User) }
        _webService.getRequest(requestUri: "user/\(userId)", completion: completion)
    }
}
