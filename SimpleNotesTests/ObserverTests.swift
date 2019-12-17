//
//  ObserverTests.swift
//  SimpleNotesTests
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import XCTest
@testable import SimpleNotes

public var user: DynamicValue<User>?
public var list: DynamicValueList<User> = DynamicValueList<User>()

class ObServerTests: XCTestCase {
    
    override class func setUp() {
        user = DynamicValue<User>(User(UserObject(id: 1, name: "João Palma")))
        
        list.data = DynamicValue<[User]>([
            User(UserObject(id: 1, name: "João Palma")),
            User(UserObject(id: 1, name: "João Palma")),
            User(UserObject(id: 1, name: "João Palma"))
        ])
    }
    
    func testAddAndNotify() {
        user!.addAndNotify(self) {
            XCTAssert(user!.value.getName() == "João Palma")
        }
    }
    
    func testListAddAndNotify() {
        list.data.addAndNotify(self) {
            XCTAssert(list.data.value.count == 3)
        }
    }
    
    func testListRemoveAndNotify() {
//        list.data.addObserver(self) {
//            XCTAssert(list.data.value.count == 2, "count is \(list.data.value.count) instead of 2")
//        }
//
//        list.remove(at: 1)
    }
    
    func testListRemoveAllAndNotify() {
//        list.data.addObserver(self) {
//            XCTAssert(list.data.value.count == 0, "count is \(list.data.value.count) instead of 0")
//        }
//
//        list.removeAll()
    }
}
