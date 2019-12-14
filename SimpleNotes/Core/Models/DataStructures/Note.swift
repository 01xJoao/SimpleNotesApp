//
//  Note.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public struct Note {
    private var _note: NoteObject
    
    init(_ note: NoteObject) {
        self._note = note
    }
    
    public func getId() -> UUID {
         return UUID(uuidString: _note.id ?? "")!
    }
    
    public func getTitle() -> String {
        return _note.title ?? ""
    }
    
    public func getContent() -> String {
        return _note.content ?? ""
    }
    
    public func getLastEdit() -> Date {
        return _note.lastEdit ?? Date()
    }
    
    public func getLocation() -> String {
        return _note.location ?? ""
    }
}
