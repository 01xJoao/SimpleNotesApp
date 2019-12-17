//
//  NoteWebService.swift
//  SimpleNotes
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol NoteWebService {
    func getNote(noteId: Int16, completion: @escaping (NoteObject?) -> Void) -> String
    func createNote(userId: Int16, note: Note, completion: @escaping (NoteObject?) -> Void) -> String
    func updateNote(note: Note, completion: @escaping (NoteObject?) -> Void) -> String
    func deleteNote(noteId: Int16, completion: @escaping (NoteObject?) -> Void) -> String
    func getUserNotes(userId: Int16, completion: @escaping ([NoteObject]?) -> Void) -> String
    func addUsersToNote(noteId: Int16, userIds: [Int16], completion: @escaping ([UserObject]?) -> Void) -> String
    func cancelRequest(id: String)
}
