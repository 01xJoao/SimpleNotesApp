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
    var keyboardButtonHeight: CGFloat = 0
    
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
        super.viewWillAppear(animated)
        if viewAlignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (formContainerStackView.frame.height > view.frame.height) {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        } else {
            scrollView.contentSize.height = view.frame.height
        }
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height) {
            scrollView.contentInset.top = 32
        } else {
            scrollView.contentInset.top = 0
        }
    }
    
    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        scrollView.contentInset.bottom = keyboardButtonHeight
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height) {
            scrollView.contentInset.bottom += self.view.safeAreaInsets.bottom
        }
        
        self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height - keyboardButtonHeight
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
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
