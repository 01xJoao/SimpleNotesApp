//
//  Note.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class Note {
    private var _note: NoteData
    
    init(_ note: NoteData) {
        self._note = note
    }
    
    public func getId() -> UUID {
        return _note.id!
    }
    
    public func getTitle() -> String {
        return _note.title ?? ""
    }
    
    public func getContent() -> String {
        return _note.content ?? ""
    }
    
    public func getLastEdit() -> Date {
        return _note.lastedit!
    }
    
    public func getLocation() -> String {
        return _note.location ?? ""
    }
}
