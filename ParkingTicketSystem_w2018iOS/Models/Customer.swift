//
//  Employee.swift
//  Demo
//
//  Created by MacStudent on 2017-10-16.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation
class Customer{
    
    var cEmailId:String?
    var cName:String?
    var birthDate: Date?
    var password: String?
    var vehicleNumber:String?
    var phoneNumber:String?
    
   static var dict = [String:Customer]()
    
    init (){
        self.cEmailId = ""
        self.cName = ""
        self.birthDate = Date()
        self.password = ""
        self.vehicleNumber = ""
        self.phoneNumber = ""
    }
    
    
    init(_ cEmailId:String,_ cName:String, _ birthdate:Date,_ password: String, _ vehicleNumber:String, _ phoneNumber:String){
        self.cEmailId = cEmailId
        self.cName = cName
        self.birthDate = birthdate
        self.password = password
        self.vehicleNumber = vehicleNumber
        self.phoneNumber = phoneNumber
    }
    
    static func addCustomer(cust:Customer) ->Bool{
        
        if self.dict[cust.cEmailId!] == nil
        {
            self.dict[cust.cEmailId!] = cust
        return true
        }
        return false
    }
    
    static func updateCustomer(cust:Customer) ->Bool{
        
        if let cust = self.dict[cust.cEmailId!]
        {
            self.dict[cust.cEmailId!] = cust
            return true
        }
        return false
    }
    
    static func getCustomer(cEmailId:String) ->Customer?
    {
        if let cust = self.dict[cEmailId]
        {
            return cust
        }
        
        return nil
    }
    
    static func loadDefaultCustomerRecords()
    {
        self.dict["a@a.com"] = Customer("a@a.com", "A Patel", Date(), "a123","a-VNO", "123-456-7890")
        self.dict["b@b.com"] = Customer("b@b.com", "B Patel", Date(), "b123","b-VNO", "123-456-7890")
        self.dict["c@c.com"] = Customer("c@c.com", "C Patel", Date(), "c123","c-VNO", "123-456-7890")
        self.dict["d@d.com"] = Customer("d@d.com", "D Patel", Date(), "d123","d-VNO", "123-456-7890")
        self.dict["e@e.com"] = Customer("e@e.com", "E Patel", Date(), "e123","e-VNO", "123-456-7890")
    }

}
