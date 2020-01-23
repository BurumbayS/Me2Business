//
//  Network.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

enum RequestStatus {
    case ok
    case error
    case fail
}

class Network {
//    static let host = "https://api.me2.aiba.kz"
    static let host = "https://api.me2.kz"
    
    static func getHeaders() -> [String : String] {
        let headers = ["Content-Type" : "application/json", "Accept" : "application/json"]
        
        return headers
    }
    
    static func getAuthorizedHeaders() -> [String: String] {
        let token = UserDefaults().object(forKey: UserDefaultKeys.token.rawValue) as! String
        let headers = ["Content-Type" : "application/json", "Accept" : "application/json", "Authorization" : "JWT \(token)"]
        
        return headers
    }
    
    static let auth = host + "/auth/auth"
    static let user = host + "/auth/user"
    static let contact = host + "/auth/contact"
    static let core = host + "/core"
    static let chat = host + "/chat"
    static let business = host + "/business"
    static let booking = host + "/business/booking"
}
