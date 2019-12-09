//
//  AppSetup.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public class AppSetup {
    public static func configure(){
        Core.initialize()
        _setViewAppearance()
        Core.startApp()
    }
    
    private static func _setViewAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor.Theme.mainBlue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.white]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Theme.white], for: UIControl.State.normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.white,
                                                                 NSAttributedString.Key.shadow: CustomUIExtensions.textShadow()]
    }
}
