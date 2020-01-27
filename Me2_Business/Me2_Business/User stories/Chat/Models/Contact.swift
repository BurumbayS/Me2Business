//
//  Contact.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

class Contact {
    let id: Int
    var blocked: Bool
    var user2: ContactUser
    
    init(json: JSON) {
        id = json["id"].intValue
        blocked = json["blocked"].boolValue
        user2 = ContactUser(json: json["user2"])
    }
}
