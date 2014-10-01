//
//  StocksAPIClient.swift
//  Stocks
//
//  Created by Axel Rivera on 9/20/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import Foundation

import Alamofire
import JSONLib

typealias QuotesBlock = (([Ticker], NSError?) -> ())

class StocksAPIClient {
    
    func quoteForSymbols(symbols: [String], completion: QuotesBlock?) {
        let symbolsStr: AnyObject = ",".join(symbols) as AnyObject
        let parameters = [ "symbols": symbolsStr]

        println("trying to fetch symbols with parameters:")
        println("\(parameters)")

        var response = Alamofire.request(.GET, HTTPBinRoute.Action("quote.json") , parameters: parameters)

        response.responseString { (request, response, responseObject, responseError) in
            if let error = responseError {
                println("error: \(error)")
                if let block = completion {
                    block([], error)
                }
                return
            }

            let parsedJSON = JSON.parse(responseObject!).value

            var quotes: [Ticker] = []
            var error: NSError?

            if let json = parsedJSON {
                if let quotesRaw = json["quotes"].array {
                    for object in quotesRaw {
                        var ticker = Ticker(json: object)
                        quotes.append(ticker)
                    }
                } else {
                    error = NSError(domain: "me.axelrivera.error", code: 0, userInfo: nil)
                }
            } else {
                error = NSError(domain: "me.axelrivera.error", code: 1, userInfo: nil)
            }

            println("quotes: \(quotes)")
            println("error: \(error)")

            if let block = completion {
                block(quotes, error)
            }
        }
    }

    // MARK: - Singleton Methods

    class var sharedClient: StocksAPIClient {
        struct Singleton {
            static let instance = StocksAPIClient()
        }

        return Singleton.instance
    }
}
