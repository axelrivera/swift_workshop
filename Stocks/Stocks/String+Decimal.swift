//
//  String+Decimal.swift
//  Stocks
//
//  Created by Axel Rivera on 9/20/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import Foundation

extension String {

    func numberString() -> String {

        var string: String

        let number = NSDecimalNumber(string: self)
        if number.isEqualToNumber(NSDecimalNumber.notANumber()) {
            string = "N/A"
        } else {
            string = NumberFormatter.number.stringFromNumber(number)
        }

        return string
    }
    
}