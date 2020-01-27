//
//  ContactUser.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

class ContactUser {
    let id: Int
    let fullName: String?
    let username: String
    let phone: String?
    let avatar: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        fullName = json["full_name"].stringValue
        username = json["username"].stringValue
        phone = json["phone"].stringValue
        avatar = json["avatar"].stringValue
    }
}

