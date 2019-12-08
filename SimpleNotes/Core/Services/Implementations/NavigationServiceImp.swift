//
//  NavigationServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class NavigationServiceImp : NavigationServiceProtocol {
    public var containerViewController : ContainerViewController?
    
    public func navigate<TViewModel>(arguments: Any?, animated: Bool) -> TViewModel? where TViewModel : ViewModelProtocol {
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: TViewModel.self, args: arguments)
                self.containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
        return nil
    }
    
    
    public func navigateModal<TViewModel>(arguments: Any?) -> TViewModel? where TViewModel : ViewModelProtocol {
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: TViewModel.self, args: arguments)
                self.containerViewController?.navigationController?.present(viewController, animated: true, completion: nil)
            }
        }
        return nil
    }
    
    public func navigateAndSetAsContainer<TViewModel>() -> TViewModel? where TViewModel : ViewModelProtocol {
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                let viewController: UIViewController = self._getViewController(type: TViewModel.self, args: nil)
                self._setContainerViewController(viewController: viewController)
            }
        }
        return nil
    }
    
    private func _getViewController<TViewModel : ViewModelProtocol>(type: TViewModel.Type = TViewModel.self, args: Any?) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = Container.resolveViewController(name: viewModelName)
       
        let vc = viewController as! BaseViewController<TViewModel>; do {
            if(args != nil){
                vc.parameterData = args
            }
        }
    
        return viewController
    }
    
    
    private func _setContainerViewController(viewController : UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        containerViewController = sceneDelegate.containerViewController
        containerViewController?.changeViewController(viewController: viewController)
    }
    
    public func close(animated: Bool) {
        containerViewController?.navigationController?.popViewController(animated: animated)
    }
    
    public func closeModal() {
        containerViewController?.navigationController?.dismiss(animated: true, completion:  {
            self._modalDismissNotify()
        })
    }
    
    private func _modalDismissNotify(){
        let parentViewcontrollerName: String = containerViewController!.getCurrentViewControllerName()
        print(parentViewcontrollerName)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: parentViewcontrollerName), object: nil)
    }
}
