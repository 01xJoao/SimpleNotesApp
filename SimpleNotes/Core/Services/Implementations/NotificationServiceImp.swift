//
//  NotificationServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 19/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import OneSignal
import Foundation

public class NotificationServiceImp : NotificationService  {
    
    private var _appSettingsService: AppSettingsService
    
    init(appSettingsService: AppSettingsService) {
        self._appSettingsService = appSettingsService
    }
    
    func getUserNotificationId() -> String? {
        return OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId
    }
    
    func sendNotification(usersNotificationIds: [String]) {
        OneSignal.postNotification([
            "contents": ["en": "Shared a message with you!"],
            "include_player_ids": usersNotificationIds
        ])
    }
    
    func askForUserPermissions() {
        if(!_appSettingsService.userAlreadyAskedForNotificationPermissions) {
            
            _appSettingsService.userAlreadyAskedForNotificationPermissions = true
            
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                if(accepted) {
                    self._appSettingsService.userNotificationId = self.getUserNotificationId() ?? ""
                }
            })
        }
    }
    
    func openAppSettings() {
        OneSignal.presentAppSettings()
    }
}
