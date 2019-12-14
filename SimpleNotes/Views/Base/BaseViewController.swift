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
    public var parameterData: Any?
    
    private var _viewModel: TViewModel!
    public var viewModel: TViewModel {
        get {
            return _viewModel
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _createViewControllerDismissNotification()
        _resolveViewModel()
    }
    
    private func _createViewControllerDismissNotification() {
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._handleViewDismiss(_:)),
           name: NSNotification.Name(rawValue: String(describing: self)),
           object: nil)
    }
    
    private func _resolveViewModel() {
        let viewModel : TViewModel = DiContainer.resolve()
        if(parameterData != nil){
            viewModel.prepare(dataObject: parameterData!)
        }
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
        if(isMovingFromParent) {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func _handleViewDismiss(_ notification: NSNotification) {
        if let params = notification.userInfo as NSDictionary? {
            viewModel.dismissChildViewNotify(dataObject: params["arguments"]!)
        }
    }
}
