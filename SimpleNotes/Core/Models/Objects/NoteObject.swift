//
//  NoteObject.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

struct NoteObject {
    var id: Int16
    var uuid: UUID?
    var title: String
    var content: String
    var lastEdit: Date?
    var location: String

    init(id: Int16 = -1, uuid: UUID? = nil, title: String = "", content: String = "", lastEdit: Date = Date(), location: String = "") {
        self.id = id
        self.uuid = uuid
        self.title = title
        self.content = content
        self.lastEdit = lastEdit
        self.location = location
    }
}
