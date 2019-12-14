//
//  DatabaseUserServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DatabaseUserServiceImp : DatabaseUserService {
    private let _userEntity = "UserData"
    
    private let _reportService: ReportService
    private var _managedContext: NSManagedObjectContext!
    
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
        
        let userData = NSManagedObject(entity: userEntity, insertInto: _managedContext)
        userData.setValue(user.getUUID(), forKey: String(describing: "id"))
        userData.setValue(user.getName(), forKey: String(describing: "name"))
        userData.setValue(user.getEmail(), forKey: String(describing: "email"))
        userData.setValue(user.getPhoto(), forKey: String(describing: "photo"))
        userData.setValue(user.getPushNotificationId(), forKey: String(describing: "pushnotificationid"))
        
        do {
            try _managedContext?.save()
        } catch let error {
            _reportService.sendError(error: error, message: "Could not save \(user) to database entity \(_userEntity)")
        }
    }
    
    public func getAllUsers() -> [UserObject] {
        var users: [UserObject] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: _userEntity)
        
        do {
            let result = try _managedContext.fetch(fetchRequest)
            for data in result as! [UserData] {
                let user = UserObject(
                        id: data.id!.uuidString,
                        name: data.name!,
                        email: data.email!,
                        photo: data.photo,
                        pushNotificationId: data.pushnotificationid
                )
                users.append(user)
            }
        } catch let error {
            _reportService.sendError(error: error, message: "Could not retrieve getUsers() data")
        }
        
        return users
    }
    
    
    
}
