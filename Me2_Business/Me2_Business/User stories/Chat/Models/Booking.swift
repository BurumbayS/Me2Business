//
//  Booking.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

enum BookingStatus: String {
    case NEW
}

class Booking {
    let id: Int
    let status: BookingStatus
    
    init(json: JSON) {
        id = json["id"].intValue
        status = BookingStatus(rawValue: json["status"].stringValue) ?? .NEW
    }
}
