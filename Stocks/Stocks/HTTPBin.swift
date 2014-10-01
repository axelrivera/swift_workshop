//
//  HTTPBin.swift
//  Stocks
//
//  Created by Axel Rivera on 9/20/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import Foundation

import Alamofire

struct HTTPHost {
    static let production = "http://stocks-api.herokuapp.com"
    static let development = "http://localhost:4000"
}

enum HTTPBinRoute: URLStringConvertible {
    case Action(String)

    var URLString: String {
        let baseURLString = HTTPHost.production
        let path: String = {
            switch self {
            case .Action(let action):
                return action
            }
        }()

        return NSURL(string: path, relativeToURL: NSURL(string: baseURLString)).absoluteString!
    }
}
