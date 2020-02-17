//
//  StudentTest.swift
//  ParkingTicketSystem_w2018iOSTests
//
//  Created by Nayay Sharma on 2019-03-17.
//  Copyright © 2019 Pritesh Patel. All rights reserved.
//

import Foundation
import XCTest



class StudentTest: XCTestCase {
    
    func testInvalidFirstName(){
       let student = Student(firstName: "Am", lastName: "Maan")
       XCTAssertFalse(student.validFirstName())
    }
    func testvalidLastName(){
        let student = Student(firstName: "Prabhjot", lastName: "Kaur")
        XCTAssertTrue(student.validFirstName())
    }
    func testAddFriend(){
        let am = Student(firstName: "Aman", lastName: "Maan")
        let pj = Student(firstName: "Prabhjot", lastName: "Kaur")
        XCTAssertTrue(am.friends.count == 0)
        am.addFriend(friend: pj)
        XCTAssertTrue(am.friends.count > 0)
    }
}
