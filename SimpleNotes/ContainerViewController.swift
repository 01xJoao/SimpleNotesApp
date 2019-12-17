//
//  ContainerViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController {
    private var currentViewController : UIViewController?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
    
    public func getVisibleViewControllerName() -> String {
        var currentViewmodelName: String
        
        if(currentViewController!.navigationController!.children.count > 1) {
            currentViewmodelName = String(describing: currentViewController!.navigationController!.topViewController!)
        } else {
            currentViewmodelName = String(describing: currentViewController!)
        }
        
        return currentViewmodelName
    }
    
    public func changeViewController(_ viewController: UIViewController) {
        if(_checkIfCurrentViewControllerIsEqualsToNew(viewController)){
            return
        }
        _removeCurrentViewController()
        _addNewViewControllerToContainer(viewController)
    }
    
    func _checkIfCurrentViewControllerIsEqualsToNew(_ viewController: UIViewController) -> Bool {
        return currentViewController == viewController.self
    }
    
    func _removeCurrentViewController() {
        if(currentViewController != nil) {
            currentViewController?.removeFromParent()
            currentViewController?.view.removeFromSuperview()
            currentViewController = nil
        }
    }

    private func _addNewViewControllerToContainer(_ viewController: UIViewController) {
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        currentViewController = viewController
    }
}
