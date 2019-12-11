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
    func showInfo(_ description: String, informationType: InfoDialogType) {
        let infoView = InfoDialogView()
        infoView.showInfo(text: description, infoType: informationType)
    }
}
