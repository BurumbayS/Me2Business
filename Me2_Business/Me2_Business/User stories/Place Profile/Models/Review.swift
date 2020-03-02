//
//  Review.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON

class ReviewUser {
    let id: Int
    var username: String?
    var avatar: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        username = json["full_name"].stringValue
        avatar = json["avatar"].stringValue
    }
}

class Review {
    let id: Int
    let body: String
    let rating: Double
    let user: ReviewUser
    var responses = [Review]()
    
    init(json: JSON) {
        id = json["id"].intValue
        body = json["body"].stringValue
        rating = json["rating"].doubleValue
        user = ReviewUser(json: json["user"])
        
        for item in json["reviews"].arrayValue {
            responses.append(Review(json: item))
        }
    }
}
