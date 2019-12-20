//
//  InfoDialogView.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

public class InfoDialogView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.tag = 0
    }
    
    public func showInfo(text: String, infoType: InfoDialogType){
        _configureView(text, infoType)
        _show()
    }
    
    private func _configureView(_ text: String, _ infoType: InfoDialogType) {
        self.backgroundColor = infoType.rawValue
        let textLabel: UILabel = UILabel(text: text, font: .boldSystemFont(ofSize: 14), textColor: UIColor.Theme.white, textAlignment: .center, numberOfLines: 2)
        
        stack(textLabel, alignment: .center).padBottom(12).padLeft(8).padRight(8).anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
    private func _show() {
        let dialogHeight: CGFloat = Utils().keyWindow.safeAreaInsets.top + LocalConstants().alertDialogHeight
        
        self.frame = CGRect.init(x: 0, y: 0, width: Utils().keyWindow.bounds.width, height: dialogHeight)
        Utils().keyWindow.addSubview(self)
        
        Animations.slideVerticaly(self, showAnimation: true, completion: { success in
            self._hide()
        })
    }
    
    private func _hide() {
        Animations.slideVerticaly(self, showAnimation: false, delay: 2.75, completion: { success in
            self._removeView()
        })
    }
    
    private func _removeView(){
        self.viewWithTag(0)?.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
