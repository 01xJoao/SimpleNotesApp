//
//  DatabaseUserService.swift
//  SimpleNotes
//
//  Created by João Palma on 14/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

protocol DatabaseUserService {
    func createUser(_ user: User)
    func getUser() -> UserObject
    func getAllUsers() -> [UserObject]
    func updateUser(_ user: User)
    func deleteUser(_ userId: String)
    func deleteAllUsers()
}
