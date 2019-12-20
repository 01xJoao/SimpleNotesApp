//
//  DialogService.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol DialogService {
    func showInfo(_ description: String, informationType: InfoDialogType)
    func showOptionAlert(title: String?, message: String?, positiveOption: String, negativeOption: String, callback: @escaping ((Bool) -> ()?))
    func startLoading()
    func stopLoading()
}
