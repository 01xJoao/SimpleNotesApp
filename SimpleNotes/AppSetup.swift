//
//  AppSetup.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public struct AppSetup {
    public static func configure(){
        Core.initialize()
        _setViewAppearance()
        Core.startApp()
    }
    
    private static func _setViewAppearance(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.Theme.mainBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.Theme.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Theme.white, .shadow: _textShadow()]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        UINavigationBar.appearance().standardAppearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().compactAppearance?.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().scrollEdgeAppearance?.backButtonAppearance = backButtonAppearance

        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.Theme.white], for: .normal)
        UIBarButtonItem.appearance().tintColor = UIColor.Theme.white
    }
    
    static private func _textShadow() -> NSShadow {
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.Theme.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
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
