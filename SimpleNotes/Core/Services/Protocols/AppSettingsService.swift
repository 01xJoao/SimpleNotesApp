//
//  AppSettingsService.swift
//  SimpleNotes
//
//  Created by João Palma on 12/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol AppSettingsService {
    var userEmail: String { get set }
    var isUserLoggedIn: Bool { get set }
    var userAlreadyAskedForNotificationPermissions: Bool { get set }
    var userNotificationId: String { get set }
    
    func clearUserData()
}
