//
//  ViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController<LoadingViewModel> {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Theme.mainBlue
        
        let button = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        button.backgroundColor = UIColor.Theme.red
        button.setTitle("Navigate", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(_navigate), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func _navigate(sender: UIButton){
        viewModel.navigateToLoginCommand()
    }
}

