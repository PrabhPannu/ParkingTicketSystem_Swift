//
//  DoubleCurrency.swift
//  Final_Project
//
//  Created by moxDroid on 2018-02-06.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import Foundation
extension Double
{
    func currency() -> String
    {
        return "$" + String(format:"%0.2f",self)
    }
}

extension Int
{
    func unit() -> String
    {
        return String(self) + " U"
    }
}
