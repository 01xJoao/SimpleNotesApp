//
//  UserObject.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

struct UserObject : Codable {
    var id: Int16
    var name: String
    var email: String
    var photo: Data?
    var password: String
    var pushNotificationId: String
    
    init(id: Int16 = -1, name: String = "", email: String = "", photo: Data? = nil, password: String = "", pushNotificationId: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.photo = photo
        self.password = password
        self.pushNotificationId = pushNotificationId
    }
}
