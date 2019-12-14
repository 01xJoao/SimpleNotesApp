//
//  User.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public struct User {
    private var _user: UserObject
    
    init(_ user: UserObject) {
        self._user = user
    }
    
    public func getId() -> String {
        return _user.id ?? ""
    }
    
    public func getUUID() -> UUID {
        return UUID(uuidString: _user.id ?? "")!
    }
    
    public func getName() -> String {
        return _user.name ?? ""
    }
    
    public func getEmail() -> String {
        return _user.email ?? ""
    }
    
    public func getPhoto() -> Data? {
        return _user.photo
    }
    
    public func getPushNotificationId() -> String {
        return _user.pushNotificationId ?? ""
    }
}
