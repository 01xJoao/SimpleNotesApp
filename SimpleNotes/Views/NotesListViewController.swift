//
//  NotesListViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 19/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class NotesListViewController : BaseViewController<NotesListViewModel> {
     
    public override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
    
    private func _setupView() {
        self.title = "Notes"
        self.view.backgroundColor = UIColor.Theme.white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
