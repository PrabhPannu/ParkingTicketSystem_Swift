//
//  ParkingTicket.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-03-01.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import Foundation
class ParkingTicket
{
    var cEmailId:String?
    var vehicleNumber:String?
    var vehicleMake:String?
    var vehicleColor:String?
    var parkingTiming:String?
    var parkingDateAndTime: Date?
    var parkingLane:String?
    var parkingSpot:String?
    var paymentMethod: String?
    var payment: Double?
    
    init(){
        self.cEmailId = ""
        self.vehicleNumber = ""
        self.vehicleMake = ""
        self.vehicleColor = ""
        self.parkingTiming = ""
        self.parkingDateAndTime = Date()
        self.parkingLane = ""
        self.parkingSpot = ""
        self.paymentMethod = ""
        self.payment = 0.0
    }
    
    init(_ cEmailId:String,
    _ vehicleNumber:String,
    _ vehicleMake:String,
    _ vehicleColor:String,
    _ parkingTiming:String,
    _ parkingDateAndTime: Date,
    _ parkingLane:String,
    _ parkingSpot:String,
    _ paymentMethod: String,
    _ payment: Double){
        self.cEmailId = cEmailId
        self.vehicleNumber = vehicleNumber
        self.vehicleMake = vehicleMake
        self.vehicleColor = vehicleColor
        self.parkingTiming = parkingTiming
        self.parkingDateAndTime = parkingDateAndTime
        self.parkingLane = parkingLane
        self.parkingSpot = parkingSpot
        self.paymentMethod = paymentMethod
        self.payment = payment
    }
    static var dict = [ParkingTicket]()
    static var dict1 = [String:ParkingTicket]()
    
    static func addParkingTicket(ticket:ParkingTicket) ->Bool{
        
        self.dict.append(ticket)
        return true
    }
    
    static func getAllParkingTicket() ->[ParkingTicket]{
        
        return self.dict
        
    }
    
    static func loadDefaultParkingRecords()
    {
        self.dict.append(ParkingTicket("a@a.com", "a-VNO", "Audi", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
        self.dict.append( ParkingTicket("a@a.com", "a-VNO", "Bentley", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
        self.dict.append(ParkingTicket("c@c.com", "c-VNO", "ferrari", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
        self.dict.append(ParkingTicket("b@b.com", "b-VNO", "jaguar", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
        self.dict.append(ParkingTicket("a@a.com", "a-VNO", "porsche", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
        self.dict.append(ParkingTicket("a@a.com", "a-VNO", "bmw", "Black", "2 Hr.", Date(), "Lane A", "P3", "Credit Card", 5.0))
    }
}
