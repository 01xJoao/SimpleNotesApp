//
//  DatabaseUserServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseUserServiceImp : DatabaseUserService {
    private let _userEntity = "UserData"
    private let _reportService: ReportService
    private var _managedContext: NSManagedObjectContext!
    
    private var _defaultFetchRequest : NSFetchRequest<NSFetchRequestResult> {
        get {
            return NSFetchRequest<NSFetchRequestResult>(entityName: _userEntity)
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
    
    public func createUser(_ user: User) {
        let userEntity = NSEntityDescription.entity(forEntityName: _userEntity, in: _managedContext)!
        let userData = UserData(entity: userEntity, insertInto: _managedContext)
        
        _saveUser(userData: userData, user: user)
    }
    
    func _saveUser(userData: UserData, user: User) {
        do {
            userData.setValue(user.getId(), forKey: String(describing: "id"))
            userData.setValue(user.getName(), forKey: String(describing: "name"))
            userData.setValue(user.getEmail(), forKey: String(describing: "email"))
            userData.setValue(user.getPhoto(), forKey: String(describing: "photo"))
            userData.setValue(user.getPushNotificationId(), forKey: String(describing: "pushnotificationid"))
            
            try _managedContext?.save()
        } catch let error {
            _reportService.sendError(error: error, message: "Could not save userdata: \(userData) to database with user values: \(user)")
        }
    }
    
    
    public func getAllUsers() -> [UserObject] {
        var users: [UserObject] = []
        let fetchRequest = _defaultFetchRequest
        
        do {
            let result = try _managedContext.fetch(fetchRequest)
            
            guard let userData = result as? [UserData] else {
                return users
            }
            
            for data in userData {
                let user = _createUserObject(data)
                users.append(user)
            }
        } catch let error {
            _reportService.sendError(error: error, message: "Could not retrieve getAllUsers() data")
        }
        
        return users
    }
    
    func _createUserObject(_ data: UserData) -> UserObject{
        return UserObject(
          id: data.id,
          name: data.name!,
          email: data.email!,
          photo: data.photo,
          pushNotificationId: data.pushnotificationid!
        )
    }
    
    func getUser(_ userId: String) -> UserObject {
        var user = UserObject()
        
        let fetchRequest = _defaultFetchRequest
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", userId)
        
        do {
            let result = try _managedContext.fetch(fetchRequest)
            
            guard let data = result.first as? UserData else {
                return user
            }
            
            user = _createUserObject(data)
        } catch let error {
            _reportService.sendError(error: error, message: "Could not retrieve getUser(), request: \(fetchRequest)")
        }
        
        return user
    }
    
    func updateUser(_ user: User) {
        let fetchRequest = _defaultFetchRequest
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", user.getId())
        
        do {
            let result = try _managedContext.fetch(fetchRequest)
            
            guard let userData = result.first as? UserData else {
                return;
            }
            
            _saveUser(userData: userData, user: user)
        } catch let error {
            _reportService.sendError(error: error, message: "Could not fetch: \(fetchRequest)")
        }
    }
    
    func deleteUser(_ userId: String) {
        let fetchRequest = _defaultFetchRequest
        fetchRequest.predicate = NSPredicate(format: "id = %@", userId)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _executeDeleteRequest(deleteRequest)
    }
    
    func deleteAllUsers() {
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
