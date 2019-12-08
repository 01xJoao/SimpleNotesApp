//
//  BaseViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class BaseViewController<TViewModel> : UIViewController where TViewModel : ViewModelProtocol {
    private var _viewModel: TViewModel!
    public var viewModel: TViewModel {
        get {
            return _viewModel
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _createDismissModalNotification()
        _resolveViewModel()
    }
    
    private func _createDismissModalNotification(){
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._handleModalDismissed),
           name: NSNotification.Name(rawValue: String(describing: self)),
           object: nil)
    }
    
    private func _resolveViewModel(){
        let viewModel : TViewModel = Container.resolve()
        viewModel.initialize()
        _viewModel = viewModel
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.appearing()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.appeared()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.disappearing()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func _handleModalDismissed() {
        viewModel.appearing()
        viewModel.appeared()
    }
}
