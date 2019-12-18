//
//  FormBaseViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class FormBaseViewController<TViewModel> : BaseViewController<TViewModel>, UIScrollViewDelegate where TViewModel : ViewModel {
    var lowestElement: UIView!
    lazy fileprivate var distanceToBottom = self.distanceFromLowestElementToBottom()
    
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.contentSize = view.frame.size
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    public let formContainerStackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        return sv
    }()
    
    public var viewAlignment: FormAlignment = .center
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)
        setupKeyboardNotifications()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        if viewAlignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        _ = distanceToBottom
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (formContainerStackView.frame.height > view.frame.height) {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        } else {
            scrollView.contentSize.height = view.frame.height
        }
    }
    
    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.origin.y - frame.height
            return distance
        }
        
        return view.frame.height - formContainerStackView.frame.maxY
    }
    
    @objc public func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height
        
        if distanceToBottom > 0 {
            scrollView.contentInset.bottom -= distanceToBottom
        }
        
        self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
    }
    
    @objc public func handleKeyboardHide() {
        self.scrollView.contentInset.bottom = 0
        self.scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    public enum FormAlignment {
        case top, center
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("error \(aDecoder)")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
