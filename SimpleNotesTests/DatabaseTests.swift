//
//  SimpleNotesTests.swift
//  SimpleNotesTests
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import XCTest
@testable import SimpleNotes

class DatabaseTests: XCTestCase {
    
    let userDatabase: DatabaseUserService = DiContainer.resolve()
    var user: [User] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let userObj = UserObject(id: 1, name: "João Palma", email: "joaowd@outlook.com", pushNotificationId: UUID().uuidString)
        let userObj1 = UserObject(id: 2, name: "Ricardo", email: "joaowd@outlook.com", pushNotificationId: UUID().uuidString)
        let userObj2 = UserObject(id: 3, name: "Filipe", email: "joaowd@outlook.com", pushNotificationId: UUID().uuidString)
        user.append(contentsOf: [User(userObj), User(userObj1), User(userObj2)])
        
    }

    func testCreateUserInDatabaseAndRetriveIt() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        userDatabase.createUser(user[0])
        
        let getUser = userDatabase.getUser(user[0].getId())
        XCTAssert(user[0].getName() == getUser.name, "Users are not the same")
    }
    
    func testCreateAndUpdateUserInDatabase() {
        userDatabase.createUser(user[1])

        user[1].setName("Ana Maria")

        userDatabase.updateUser(user[1])

        let getUser = userDatabase.getUser(user[1].getId())
        XCTAssert(getUser.name == "Ana Maria", "Users name are not the same")
    }

    func testDeleteUserFromDatabase() {
        userDatabase.deleteUser(user[1].getId())

        let getUser = userDatabase.getUser(user[1].getId())

        XCTAssert(getUser.name.isEmpty, "User not deleted")
    }

    func testDeleteAllUsers() {
        userDatabase.createUser(user[2])

        userDatabase.deleteAllUsers()
        let getUsers = userDatabase.getAllUsers()

        XCTAssert(getUsers.isEmpty, "Not all users got deleted")
    }
}
