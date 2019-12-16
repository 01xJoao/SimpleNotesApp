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
    
    func getUser(userId: Int16, completion: @escaping (_ user: UserObject?) -> Void) -> String {
        let cancelationToken = _webService.getRequest(requestUri: "user/\(userId)"){ user in completion(user) }
        return cancelationToken
    }
}
