//
//  Tag.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

class Tag {
    let id: Int
    let name: String
    let tag_type: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        tag_type = json["tag_type"].stringValue
    }
}

