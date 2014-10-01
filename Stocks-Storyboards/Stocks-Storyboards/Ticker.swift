//
//  Ticker.swift
//  Stocks
//
//  Created by Axel Rivera on 7/5/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import Foundation
import UIKit
import JSONLib

class Ticker {

    struct Config {
        static let notAvailable = "N/A"
    }

    var symbol: String!
    var name: String!
    var close: String!
    var change: String!
    var percentageChange: String!
    var lastTradeDateString: String!
    var lastTradeTime: String!
    var stockExchange: String!
    var previousClose: String!
    var open: String!
    var low: String!
    var high: String!
    var volume: String!

    var priceAndPercentChange: String {
        return "\(change) (\(percentageChange))"
    }

    var formattedOpen: String {
        return (open != nil) ? open.numberString() : Config.notAvailable
    }

    var formattedClose: String {
        return (close != nil) ? close.numberString() : Config.notAvailable
    }

    var formattedPreviousClose: String {
        return (previousClose != nil) ? previousClose.numberString() : Config.notAvailable
    }

    var formattedLow: String {
        return (low != nil) ? low.numberString() : Config.notAvailable
    }

    var formattedHigh: String {
        return (high != nil) ? high.numberString() : Config.notAvailable
    }

    var formattedVolume: String {
        return (volume != nil) ? volume.numberString() : Config.notAvailable
    }

    var changeColor: UIColor {

        let changeNumber = NumberFormatter.change.numberFromString(change)?.doubleValue
        var color: UIColor = UIColor.blackColor()

        if changeNumber < 0.0 {
            color = UIColor.redColor()
        } else if changeNumber == 0.0 {
            color = UIColor.yellowColor()
        } else {
            color = UIColor.greenColor()
        }
        
        return color
    }

    init(json: JSON) {
        symbol = json["symbol"].string
        name = json["name"].string
        close = json["close"].string
        change = json["change"].string
        percentageChange = json["change_in_percent"].string
        stockExchange = json["stock_exchange"].string
        previousClose = json["previous_close"].string
        open = json["open"].string
        low = json["low"].string
        high = json["high"].string
        volume = json["volume"].string
    }

    // MARK: - Public Methods

    func toArray() -> [[String: String?]] {
        var array = [[String: String?]]()
        var dictionary = [String: String?]()

        dictionary = [ "label": "Name", "value": name ]
        array.append(dictionary)

        dictionary = [ "label": "Symbol", "value": symbol ]
        array.append(dictionary)

        dictionary = [ "label": "Exchange", "value": stockExchange ]
        array.append(dictionary)

        dictionary = [ "label": "Open", "value": open ]
        array.append(dictionary)

        dictionary = [ "label": "Close", "value": close ]
        array.append(dictionary)

        dictionary = [ "label": "Change", "value": priceAndPercentChange ]
        array.append(dictionary)

        dictionary = [ "label": "Prev Close", "value": previousClose ]
        array.append(dictionary)

        dictionary = [ "label": "High", "value": high ]
        array.append(dictionary)

        dictionary = [ "label": "Low", "value": low ]
        array.append(dictionary)

        dictionary = [ "label": "Volume", "value": formattedVolume ]
        array.append(dictionary)

        return array
    }
}
