//
//  AddEventViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

enum AddEventSectionType {
    case mainInfo
    case date
    case time
    case price
    case tags
}

class AddEventViewModel {
    let sections = [AddEventSectionType.mainInfo, .date, .time, .price, .tags]
}
