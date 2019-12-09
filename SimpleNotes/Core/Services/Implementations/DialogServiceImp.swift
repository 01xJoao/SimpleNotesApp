//
//  DialogServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class DialogServiceImp: DialogServiceProtocol {
    func showAlert(_ description: String, alertType: AlertDialogType) {
        let alertView = AlertDialogView(frame: CGRect())
        alertView.showAlert(text: description, alertType: alertType)
    }
}
