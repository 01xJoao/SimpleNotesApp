//
//  Enums.swift
//  SimpleNotes
//
//  Created by João Palma on 09/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

//enum DialogAlertType {
//    case good, bad, info
//}

public enum InfoDialogType {
    case good
    case bad
    case info
}

extension InfoDialogType: RawRepresentable {
    public typealias RawValue = UIColor

    public init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.Theme.green: self = .good
        case UIColor.Theme.red: self = .bad
        case UIColor.Theme.darkBlue: self = .info
        default: return nil
        }
    }

public var rawValue: RawValue {
        switch self {
        case .good: return UIColor.Theme.green
        case .bad: return UIColor.Theme.red
        case .info: return UIColor.Theme.darkBlue
        }
    }
}
