//
//  DatabaseNoteServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseNoteServiceImp : DatabaseNoteService {
    private let _noteEntity = "NoteData"
        private let _reportService: ReportService
        private var _managedContext: NSManagedObjectContext!
        
        private var _defaultFetchRequest : NSFetchRequest<NSFetchRequestResult> {
            get {
                return NSFetchRequest<NSFetchRequestResult>(entityName: _noteEntity)
            }
        }
        
        init(reportService: ReportService) {
            self._reportService = reportService
            _setManagerContext()
        }
        
        private func _setManagerContext() {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            _managedContext = appDelegate?.persistentContainer.viewContext
        }
        
        public func createNote(_ note: Note) {
            let noteEntity = NSEntityDescription.entity(forEntityName: _noteEntity, in: _managedContext)!
            let noteData = NoteData(entity: noteEntity, insertInto: _managedContext)
            
            _saveNote(noteData: noteData, note: note)
        }
        
        func _saveNote(noteData: NoteData, note: Note) {
            do {
                noteData.setValue(note.getUUID(), forKey: String(describing: "id"))
                noteData.setValue(note.getTitle(), forKey: String(describing: "title"))
                noteData.setValue(note.getContent(), forKey: String(describing: "content"))
                noteData.setValue(note.getLastEdit(), forKey: String(describing: "lastedit"))
                noteData.setValue(note.getLocation(), forKey: String(describing: "location"))
                
                try _managedContext?.save()
            } catch let error {
                _reportService.sendError(error: error, message: "Could not save notedata: \(noteData) to database with note values: \(note)")
            }
        }
        
        
        public func getAllNotes() -> [NoteObject] {
            var notes: [NoteObject] = []
            let fetchRequest = _defaultFetchRequest
            
            do {
                let result = try _managedContext.fetch(fetchRequest)
                
                guard let noteData = result as? [NoteData] else {
                    return notes
                }
                
                for data in noteData {
                    let note = _createNoteObject(data)
                    notes.append(note)
                }
            } catch let error {
                _reportService.sendError(error: error, message: "Could not retrieve getAllNotes() data")
            }
            
            return notes
        }
    
        func _createNoteObject(_ data: NoteData) -> NoteObject {
            return NoteObject(
              id: data.id!.uuidString,
              title: data.title!,
              content: data.content!,
              lastEdit: data.lastedit!,
              location: data.location!
            )
        }
        
        func getNote(_ noteId: String) -> NoteObject {
            var note = NoteObject()
            
            let fetchRequest = _defaultFetchRequest
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", noteId)
            
            do {
                let result = try _managedContext.fetch(fetchRequest)
                
                guard let data = result.first as? NoteData else {
                    return note
                }
                
                note = _createNoteObject(data)
            } catch let error {
                _reportService.sendError(error: error, message: "Could not retrieve getNote(), request: \(fetchRequest)")
            }
            
            return note
        }
        
        func updateNote(_ note: Note) {
            let fetchRequest = _defaultFetchRequest
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", note.getId())
            
            do {
                let result = try _managedContext.fetch(fetchRequest)
                
                guard let noteData = result.first as? NoteData else {
                    return;
                }
                
                _saveNote(noteData: noteData, note: note)
            } catch let error {
                _reportService.sendError(error: error, message: "Could not fetch: \(fetchRequest)")
            }
        }
        
        func deleteNote(_ noteId: String) {
            let fetchRequest = _defaultFetchRequest
            fetchRequest.predicate = NSPredicate(format: "id = %@", noteId)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _executeDeleteRequest(deleteRequest)
        }
        
        func deleteAllNotes() {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: _defaultFetchRequest)
            _executeDeleteRequest(deleteRequest)
        }
        
        func _executeDeleteRequest(_ deleteRequest: NSPersistentStoreRequest){
            do {
                try _managedContext.execute(deleteRequest)
            } catch let error {
                _reportService.sendError(error: error, message: "Could not execute: \(deleteRequest))")
            }
        }
    }
