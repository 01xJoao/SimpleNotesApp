//
//  WebServicesTests.swift
//  SimpleNotesTests
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import XCTest
@testable import SimpleNotes

var users: [User] = []

class WebServiceTests: XCTestCase {
    
    let userWebService: UserWebService = DiContainer.resolve()
    
    override class func setUp() {
        let userObject = UserObject(id: 0, name: "Ricardo", email: "ricardo@gmail.com", photo: nil, pushNotificationId: "TTT-AAA")
        let userObject2 = UserObject(id: 1, name: "Joao", email: "ricardo@gmail.com", photo: nil, pushNotificationId: "TTT-AAA")
        users.append(User(userObject))
        users.append(User(userObject2))
    }
    
    func testCreateUser() {
        _ = userWebService.createUser(user: users.first!) { result in
            if(result != nil) {
                print(result!)
                XCTAssert(result!.name == "Ricardo")
                self.deleteUser(result!.id)
            } else {
                XCTAssert(result == nil)
            }
        }
    }
    
    func testGetUserWithId1() {
        _ = userWebService.getUser(userId: 1) { result in
            if(result != nil) {
                print(result!)
                XCTAssert(result!.name == "João Palma")
            } else {
                XCTAssert(result == nil)
            }
        }
    }
    
    func testUpdateUser() {
        let userobj = UserObject(id: 1, name: "Joao", email: "ricardo@gmail.com")
        let user = User(userobj)
        
        _ = userWebService.updateUser(user: user) { result in
            if(result != nil) {
               print(result!)
               XCTAssert(result!.name == "Joao")
            } else {
               XCTAssert(result == nil)
            }
        }
    }
    
    func testGetAllUsers(){
        _ = userWebService.getAllUsers() { result in
            if(result != nil) {
               print(result!)
                XCTAssert(result!.first!.name == "João Palma")
            } else {
               XCTAssert(result == nil)
            }
        }
    }
    
    func deleteUser(_ id: Int16) {
        _ = userWebService.deleteUser(userId: id) { result in
            if(result != nil) {
               print(result!)
               XCTAssert(result!.name == "Ricardo")
            } else {
               XCTAssert(result == nil)
            }
        }
    }
}
