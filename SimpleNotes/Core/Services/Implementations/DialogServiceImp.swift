//
//  DialogServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import MaterialComponents.MaterialActivityIndicator

public class DialogServiceImp: DialogService {
    
    private var _activityIndicator = MDCActivityIndicator()
    private var _navigationService: NavigationService
    
    init(navigationService: NavigationService) {
        self._navigationService = navigationService
        _configureActivityIndicator()
    }
    
    func showInfo(_ description: String, informationType: InfoDialogType) {
        let infoView = InfoDialogView()
        infoView.showInfo(text: description, infoType: informationType)
    }
    
    func showOptionAlert(title: String?, message: String?, positiveOption: String, negativeOption: String, callback: @escaping ((Bool) -> ()?)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: positiveOption, style: .default, handler: { (alert: UIAlertAction!) in callback(true) }))
        alert.addAction(UIAlertAction(title: negativeOption, style: .cancel, handler: { (alert: UIAlertAction!) in callback(false) }))
        
        let visibleViewController = _navigationService.visibleViewController()
        visibleViewController.present(alert, animated: true)
    }
    
    func startLoading() {
        _activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        _activityIndicator.stopAnimating()
    }
    
    func _configureActivityIndicator() {
        let mainView = Utils().keyWindow
        
        _activityIndicator.sizeToFit()
        _activityIndicator.center = mainView.center
        _activityIndicator.radius = 22
        _activityIndicator.strokeWidth = 3.5
        _activityIndicator.cycleColors = [UIColor.Theme.mainBlue]
        
        mainView.addSubview(_activityIndicator)
    }
}
