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
    
    public func visibleViewController() -> UIViewController {
        return containerViewController!
    }
    
    public func navigate<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool){
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: viewModel, args: arguments)
                self.containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    public func navigateModal<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type, arguments: Any?) {
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: viewModel, args: arguments)
                self.containerViewController?.navigationController?.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    public func navigateAndSetAsContainer<TViewModel : ViewModelProtocol>(viewModel: TViewModel.Type) {
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: viewModel, args: nil)
                self._setContainerViewController(viewController)
            }
        }
    }
    
    private func _getViewController<TViewModel : ViewModelProtocol>(type: TViewModel.Type, args: Any?) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)
       
        let vc = viewController as! BaseViewController<TViewModel>; do {
            if(args != nil){
                vc.parameterData = args
            }
        }
    
        return viewController
    }
    
    
    private func _setContainerViewController(_ viewController : UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        containerViewController = sceneDelegate.containerViewController
        containerViewController?.changeViewController(viewController)
    }
    
    public func close(arguments: Any?, animated: Bool) {
        containerViewController?.navigationController?.popViewController(animated: animated)
        _dismissViewNotify(args: arguments)
    }
    
    public func closeModal(arguments: Any?) {
        containerViewController?.navigationController?.dismiss(animated: true, completion: nil)
        _dismissViewNotify(args: arguments)
    }
    
    private func _dismissViewNotify(args: Any?) {
        let params: [String: Any] = ["arguments": args as Any]
        let parentViewcontrollerName: String = containerViewController!.getVisibleViewControllerName()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: parentViewcontrollerName), object: nil, userInfo: params)
    }
}
