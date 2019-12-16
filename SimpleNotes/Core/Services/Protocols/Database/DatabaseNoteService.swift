//
//  DatabaseNoteService.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol DatabaseNoteService {
    func createNote(_ note: Note)
    func getNote(_ uuid: UUID) -> NoteObject
    func getAllNotes() -> [NoteObject]
    func updateNote(_ note: Note)
    func deleteNote(_ uuid: UUID)
    func deleteAllNotes()
}
