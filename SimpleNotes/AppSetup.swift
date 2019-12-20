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
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.Theme.mainBlue
            appearance.titleTextAttributes = [.foregroundColor: UIColor.Theme.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Theme.white, .shadow: CustomUIExtensions.textShadow()]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.Theme.white], for: .normal)
        } else {
            UINavigationBar.appearance().tintColor = UIColor.Theme.darkBlue
            UINavigationBar.appearance().barTintColor = UIColor.Theme.darkBlue
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}

extension UINavigationController {
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.topViewController?.navigationItem.backBarButtonItem = backButton
        self.topViewController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
