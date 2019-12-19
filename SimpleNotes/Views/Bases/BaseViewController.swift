//
//  BaseViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class BaseViewController<TViewModel> : UIViewController where TViewModel : ViewModel {
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
        let viewModel : TViewModel = DiContainer.resolve()
        if(parameterData != nil) {
            viewModel.prepare(dataObject: parameterData!)
        }
        _viewModel = viewModel
        _viewModel.initialize()
    }
    
    private func _createViewControllerCloseNotification() {
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._handleViewDismiss(_:)),
           name: NSNotification.Name(rawValue: String(describing: TViewModel.self)),
           object: nil)
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
        if(isMovingFromParent) {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func _handleViewDismiss(_ notification: NSNotification) {
        if let params = notification.userInfo as NSDictionary? {
            viewModel.dataNotify(dataObject: params["arguments"]!)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
