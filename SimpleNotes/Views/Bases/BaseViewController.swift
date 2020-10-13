//
//  BaseViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class BaseViewController<TViewModel : ViewModel> : UIViewController {
    public var parameterData: Any?
    
    private var _viewModel: TViewModel!
    public var viewModel: TViewModel {
        get {
            return _viewModel
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _resolveViewModel()
        _createViewControllerCloseNotification()
    }
    
    private func _resolveViewModel() {
        let vm : TViewModel = DiContainer.resolve()
        if(parameterData != nil) {
            vm.prepare(dataObject: parameterData!)
        }
        _viewModel = vm
        _viewModel.initialize()
    }
    
    private func _createViewControllerCloseNotification() {
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._handleViewDismiss(_:)),
           name: NSNotification.Name(rawValue: String(describing: TViewModel.self)),
           object: nil)
    }
    
    @objc func _handleViewDismiss(_ notification: NSNotification) {
        if let params = notification.userInfo as NSDictionary? {
            _viewModel.dataNotify(dataObject: params["arguments"]!)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _viewModel.appearing()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _viewModel.disappearing()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        if(isMovingFromParent) {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
