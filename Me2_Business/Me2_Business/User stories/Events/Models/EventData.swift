//
//  EventData.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/1/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum EventChangesType {
    case create
    case update
}

class EventData {
    let changesType: EventChangesType
    
    var name: String!
    var description: String!
    var event_type: Int!
    var place: Int!
    var start: String?
    var end: String?
    var time_start: String?
    var time_end: String?
    var price_min: Int!
    var price_max: Int!
    var dateType: DateType?
    var image: UIImage!
    var tags: [Int] = []
    
    init(changesType: EventChangesType) {
        self.changesType = changesType
    }
    
    func getParams() -> Parameters {
        var params = Parameters()
        
        params["name"] = name
        params["description"] = description
        params["event_type"] = event_type
        params["place"] = 5
        if start != nil { params["start"] = start }
        if end != nil { params["end"] = end }
        if time_start != nil { params["time_start"] = time_start }
        if time_end != nil { params["time_end"] = time_end }
        params["price_min"] = price_min
        params["price_max"] = price_max
        params["date_type"] = dateType?.rawValue
        params["tags"] = tags
        
        return params
    }
    
    func requiredFieldsFilled() -> Bool {
        guard let _ = name else { return false }
        guard let _ = description else { return false }
        guard let _ = event_type else { return false }
        guard let _ = price_min else { return false }
        guard let _ = price_max else { return false }
        guard let _ = dateType else { return false }
        guard let _ = image, changesType == .create else { return false }
        guard tags.count > 0 else { return false }
        
        return true
    }
}
