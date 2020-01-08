//
//  Booking.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON
import Alamofire

enum BookingStatus: String {
    case NEW
    case APPROVED
    case REJECTED
}

class Booking {
    let id: Int
    let status: BookingStatus
    
    init(json: JSON) {
        id = json["id"].intValue
        status = BookingStatus(rawValue: json["status"].stringValue) ?? .NEW
    }
    
    func accept(messageID: Int64) {
        let url = Network.booking + "/approve/"
        let params: Parameters = ["id": id, "message_id": messageID]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                case .failure(_):
                    
                    let json = JSON(response.data as Any)
                    print(json)
                    
                }
        }
    }
    
    func reject() {
        
    }
    
    func edit() {
        
    }
}
