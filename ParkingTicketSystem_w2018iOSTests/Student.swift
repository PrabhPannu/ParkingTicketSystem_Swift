//
//  Student.swift
//  ParkingTicketSystem_w2018iOSTests
//
//  Created by Nayay Sharma on 2019-03-17.
//  Copyright © 2019 Pritesh Patel. All rights reserved.
//

import Foundation

class Student {
    let firstName : String
    let lastName : String
    var friends : [Student] = []
    
    init(firstName:String,lastName:String) {
        self.firstName=firstName
        self.lastName=lastName
    }
    func addFriend(friend: Student){
        friends.append(friend)
    }
    func validFirstName() ->  Bool {
        return firstName.count>3
    }
    func validLastName() ->  Bool {
        return lastName.count>3
    }
}
