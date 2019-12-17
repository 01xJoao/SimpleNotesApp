//
//  NoteWebServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class NoteWebServiceImp : NoteWebService {    
    private let _webService: WebService
    
    init(webService: WebService) {
        self._webService = webService
    }
    
    func getNote(noteId: Int16, completion: @escaping (NoteObject?) -> Void) -> String {
        _webService.getRequest(requestUri: "note/\(noteId)") { note in completion(note) }
    }
    
    func createNote(userId: Int16, note: Note, completion: @escaping (NoteObject?) -> Void) -> String {
        _webService.postRequest(requestUri: "note/create/\(userId)", params: note) { note in completion(note) }
    }
    
    func updateNote(note: Note, completion: @escaping (NoteObject?) -> Void) -> String {
        _webService.putRequest(requestUri: "note", params: note) { note in completion(note) }
    }
    
    func deleteNote(noteId: Int16, completion: @escaping (NoteObject?) -> Void) -> String {
        _webService.deleteRequest(requestUri: "note/\(noteId)") { note in completion(note) }
    }
    
    func getUserNotes(userId: Int16, completion: @escaping ([NoteObject]?) -> Void) -> String {
        _webService.getRequest(requestUri: "user/\(userId)/notes") { note in completion(note) }
    }
    
    func addUsersToNote(noteId: Int16, userIds: [Int16], completion: @escaping ([UserObject]?) -> Void) -> String {
        _webService.putRequest(requestUri: "note/\(noteId)", params: userIds) { users in completion(users) }
    }
    
    func cancelRequest(id: String) {
        _webService.cancelRequest(id)
    }
}
