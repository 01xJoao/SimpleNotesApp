//
//  AlertDialogView.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

public class AlertDialogView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func showAlert(text: String, alertType: AlertDialogType){
        _createView(text, alertType)
        _show()
    }
    
    private func _createView(_ text: String, _ alertType: AlertDialogType) {
        self.clipsToBounds = true
        self.backgroundColor = alertType.rawValue
        self.tag = 0
        
        let textLabel: UILabel = UILabel.init(text: text, textColor: UIColor.Theme.white)
        hstack(textLabel).padLeft(10).padRight(10)
    }
    
    private func _show() {
        let keyWindow: UIWindow? = UIApplication.shared.windows.first {$0.isKeyWindow}
        let dialogHeight: CGFloat = (keyWindow?.safeAreaInsets.top)! + LocalConstants().alertDialogHeight
        self.frame = CGRect.init(x: 0, y: 0, width: (keyWindow?.bounds.width)!, height: dialogHeight)
        keyWindow?.addSubview(self)
    }
    
    private func _removeView(){
        self.viewWithTag(0)?.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
