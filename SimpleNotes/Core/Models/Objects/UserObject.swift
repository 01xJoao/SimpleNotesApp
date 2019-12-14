//
//  UserObject.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

struct UserObject {
    var id: String?
    var name: String?
    var email: String?
    var photo: Data?
    var pushNotificationId: String?
    
    init(id: String = "", name: String = "", email: String = "", photo: Data? = nil, pushNotificationId: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.photo = photo
        self.pushNotificationId = pushNotificationId
    }
}
