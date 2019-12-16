//
//  WebServicesTests.swift
//  SimpleNotesTests
//
//  Created by João Palma on 16/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import XCTest
@testable import SimpleNotes

class WebServiceTests: XCTestCase {
    let userWebService: UserWebService = DiContainer.resolve()
    
    override class func setUp() {}
    
    func testGetUser() {
        userWebService.getUser(userId: 2) { result in
            if(result != nil) {
                print(result!)
                XCTAssert(result!.name == "João Palma")
            } else {
                XCTAssert(result == nil)
            }
        }
    }
}
