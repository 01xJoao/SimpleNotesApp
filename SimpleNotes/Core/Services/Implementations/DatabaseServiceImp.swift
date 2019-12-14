//
//  DatabaseServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 13/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseServiceImp : DatabaseService {
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
    
    public func createUser(user: User){
        let userEntity = NSEntityDescription.entity(forEntityName: user.getEntity(), in: _managedContext)!
        
        let userData = NSManagedObject(entity: userEntity, insertInto: _managedContext)
        userData.setValue(user.getId(), forKey: String(describing: "id"))
        userData.setValue(user.getName(), forKey: String(describing: "name"))
        userData.setValue(user.getEmail(), forKey: String(describing: "email"))
        userData.setValue(user.getPhoto(), forKey: String(describing: "photo"))
        userData.setValue(user.getPushNotificationId(), forKey: String(describing: "pushnotificationid"))
        
        do {
            try _managedContext?.save()
        } catch let error {
            _reportService.sendError(error: error, message: "Could not save \(user) to database entity \(user.getEntity())")
        }
    }
    
}
