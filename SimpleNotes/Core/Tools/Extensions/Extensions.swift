//
//  Extensions.swift
//  SimpleNotes
//
//  Created by João Palma on 08/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}
