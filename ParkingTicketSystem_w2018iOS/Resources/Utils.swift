//
//  Utils.swift
//  Final_Project
//
//  Created by moxDroid on 2018-02-27.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import Foundation
import UIKit

class Utils
{
    static func getCarMakeArray() -> [String]
    {
        return ["Acura",
            "Audi",
            "AlfaRomeo",
            "Bentley",
            "BMW",
            "Bugatti",
            "Buick",
            "Cadillac",
            "Chevrolet",
            "Chrysler",
            "Citroen",
            "Dodge",
            "Ferrari",
            "Honda",
            "Hyundai",
            "Infiniti",
            "Jaguar",
            "Kia",
            "Lamborghini",
            "Lexus",
            "Maserati",
            "Mazda",
            "Mercedes",
            "Peugeot",
            "Porsche",
            "RollsRoyce",
            "Tesla",
            "Toyota"]
    }
    
    static func getCarColorArray() -> [String]
    {
        return ["White",
            "Purple",
            "White Diamond Pearl",
            "Silver",
            "Red",
            "Black",
            "Grey",
            "Blue",
            "Brown",
            "Green",
            "Candy Apple"]
    }
    
    static func getParkingLaneArray() -> [String]
    {
        return ["Lane A",
        "Lane B",
        "Lane C",
        "Lane D",
        "Lane E",
        "Lane F"]
    }
    
    static func getParkingSpotArray() -> [String]
    {
        return ["P1",
        "P2",
        "P3",
        "P4",
        "P5",
        "P6",
        "P7",
        "P8",
        "P9",
        "P10"]
    }
    
    static func getPaymentMethodsArray() -> [String]
    {
        return ["Cash",
        "Credit Card",
        "Master Card",
        "Debit Card",
        "PayPal",
        "Bitcoin"]
    }
    
    static func getPaymentRateArray() -> [Double]
    {
        return [5.0, 7.0, 10.0, 13.0, 15.0]
    }
    
    static func uicolorFromHex(rgbValue:UInt32) ->UIColor
    {
        let red = CFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:CGFloat(red), green:green, blue:blue, alpha:1.0)
        
    }
    
    static func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)
        
        //let ms = Int(interval.truncatingRemainder(dividingBy: 1) * 1000)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds) as String
    }
}


