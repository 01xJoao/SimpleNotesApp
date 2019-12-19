//
//  NotificationService.swift
//  SimpleNotes
//
//  Created by João Palma on 19/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol NotificationService {
    func getUserNotificationId() -> String?
    func sendNotification(usersNotificationIds: [String])
    func askForUserPermissions()
    func openAppSettings()
}
