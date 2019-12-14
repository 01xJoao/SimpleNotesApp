//
//  SimpleNotesTests.swift
//  SimpleNotesTests
//
//  Created by João Palma on 07/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import XCTest
@testable import SimpleNotes

class SimpleNotesTests: XCTestCase {
    
    let userDatabase: DatabaseUserService = DiContainer.resolve()
    var user: User!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let userObj = UserObject(id: UUID().uuidString, name: "João Palma", email: "joaowd@outlook.com", pushNotificationId: UUID().uuidString)
        user = User(userObj)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUserInDatabaseAndRetriveIt() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        userDatabase.createUser(user)
        
        let getUser = userDatabase.getUser(user.getId())
        XCTAssert(user.getId() == getUser.id, "Users are not the same")
    }
    
    func testCreateAndUpdateUserInDatabase() {
        userDatabase.createUser(user)
        
        user.setName("João")
        
        userDatabase.updateUser(user)
        
        let getUser = userDatabase.getUser(user.getId())
        XCTAssert(getUser.name == "João", "Users name are not the same")
    }
    
    func testDeleteUserFromDatabase() {
        userDatabase.deleteUser(user.getId())
        
        let getUser = userDatabase.getUser(user.getId())
        
        XCTAssert(user.getId() != getUser.id, "User not deleted")
    }
    
    func testDeleteAllUsers() {
        userDatabase.createUser(user)
        let user2 = user!
        userDatabase.createUser(user2)
    
        userDatabase.deleteAllUsers()
        let getUsers = userDatabase.getAllUsers()
        
        XCTAssert(getUsers.isEmpty, "Not all users got deleted")
    }
}
