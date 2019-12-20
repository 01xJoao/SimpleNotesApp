//
//  NavigationServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class NavigationServiceImp : NavigationService {
    
    private var containerViewController : ContainerViewController?
    private var _viewStack: [String] = []
    
    public func visibleViewController() -> UIViewController {
        return containerViewController!
    }
    
    public func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool){
        _viewStack.append(String(describing: viewModel.self))
        
        let viewController: UIViewController = self._getViewController(type: viewModel, args: arguments)
        self.containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?) {
        _viewStack.append(String(describing: viewModel.self))
        
        let viewController: UIViewController = self._getViewController(type: viewModel, args: arguments)
        self.containerViewController?.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    public func navigateAndSetAsContainer<TViewModel : ViewModel>(viewModel: TViewModel.Type) {
        _viewStack.removeAll()
        _viewStack.append(String(describing: viewModel.self))
        
        let viewController: UIViewController = self._getViewController(type: viewModel, args: nil)
        let navigationController = UINavigationController(rootViewController: viewController)
        self._setNewContainerViewController(navigationController)
    }
    
    private func _getViewController<TViewModel : ViewModel>(type: TViewModel.Type, args: Any?) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)
        
        if let vc = viewController as? BaseViewController<TViewModel> {
            if(args != nil) {
                vc.parameterData = args
            }
        } else {
            let vc = viewController as! BaseCollectionViewController<TViewModel>
            if(args != nil) {
                vc.parameterData = args
            }
        }
    
        return viewController
    }
    
    private func _setNewContainerViewController(_ viewController : UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        containerViewController = sceneDelegate.containerViewController
        containerViewController?.changeViewController(viewController)
    }
    
    public func close(arguments: Any?, animated: Bool) {
        _viewStack.removeLast()
        containerViewController?.navigationController?.popViewController(animated: animated)
        _notifyView(arguments)
    }
    
    public func closeModal(arguments: Any?) {
        _viewStack.removeLast()
        containerViewController?.navigationController?.dismiss(animated: true, completion: nil)
        _notifyView(arguments)
    }
    
    private func _notifyView(_ args: Any?) {
        if(args != nil) {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: _viewStack.last!),
                object: nil,
                userInfo: ["arguments": args!])
        }
    }
}
