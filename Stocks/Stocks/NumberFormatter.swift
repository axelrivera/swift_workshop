//
//  NumberFormatter.swift
//  Stocks
//
//  Created by Axel Rivera on 9/20/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import Foundation

struct NumberFormatter {
    
    static var number: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 2
        return formatter
    }

    static var change: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.positivePrefix = "+"
        formatter.maximumFractionDigits = 2
        return formatter
    }

    static var integer: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = 0
        return formatter
    }

}