//
//  AppDelegate.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import CoreData
import Sentry
import OneSignal

fileprivate let _sentryDNS: String = "https://17fc5da01c414945af356999aca3aecc@sentry.io/1855619"
fileprivate let _oneSignalId: String = "328b8558-e708-4934-8a58-c7b651ca5026"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //START OneSignal initialization code
    let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _instantiateSentryService()
        _instantiateOneSignal(launchOptions)
        return true
    }
    
    func _instantiateSentryService() {
        do {
            Client.shared = try Client(dsn: _sentryDNS)
            try Client.shared?.startCrashHandler()
        } catch let error {
            print("\(error)")
        }
    }
    
    func _instantiateOneSignal(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        #if targetEnvironment(simulator)
            return
        #else
            OneSignal.initWithLaunchOptions(launchOptions,
                appId: "328b8558-e708-4934-8a58-c7b651ca5026",
                handleNotificationAction: nil,
                settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        #endif
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SimpleNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

