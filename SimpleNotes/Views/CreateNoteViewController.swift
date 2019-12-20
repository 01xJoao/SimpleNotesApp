//
//  CreateNoteViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 20/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import UIKit

class CreateNoteViewController : BaseViewController<CreateNoteViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
    
    private func _setupView() {
        self.view.backgroundColor = UIColor.Theme.white
    }
}
