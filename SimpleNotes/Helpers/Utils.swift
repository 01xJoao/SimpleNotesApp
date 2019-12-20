//
//  Utils.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation

public struct Utils {
    
    public static func serializeJson<T : Codable>(object: T) -> NSDictionary {
        let jsonData = try? JSONEncoder().encode(object)
        let jsonResult = try? JSONSerialization.jsonObject(with: jsonData!) as? NSDictionary
        return jsonResult ?? ["" : ""]
    }
    
    public let keyWindow: UIWindow = UIApplication.shared.windows.first {$0.isKeyWindow}!
    
    public static func isValidEmail(_ emailStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
}
