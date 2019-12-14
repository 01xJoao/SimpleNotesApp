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
    private let _managedContext: NSManagedObjectContext?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        _managedContext = appDelegate?.persistentContainer.viewContext
    }
}
