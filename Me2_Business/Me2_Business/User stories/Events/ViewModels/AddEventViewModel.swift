//
//  AddEventViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum AddEventSectionType {
    case mainInfo
    case date
    case time
    case price
    case tags
}

class EventData {
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
    var dateType: DateType!
    var image: UIImage!
    var tags: [Int] = []
}

class AddEventViewModel {
    let sections = [AddEventSectionType.mainInfo, .date, .time, .price, .tags]
    let eventData = EventData()
}
