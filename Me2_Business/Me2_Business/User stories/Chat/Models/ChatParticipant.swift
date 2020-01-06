//
//  ChatParticipant.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

class ChatParticipant {
    let id: Int
    let avatar: String
    let fullName: String
    let username: String
    
    init(json: JSON) {
        id = json["id"].intValue
        avatar = json["avatar"].stringValue
        fullName = json["full_name"].stringValue
        username = json["username"].stringValue
    }
}
