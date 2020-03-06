//
//  EditWorlTimeViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

class EditWorlTimeViewModel {
    let weekdays = [WeekDayName.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    let placeInfo: Place
    
    init(place: Place) {
        self.placeInfo = place
        
        self.placeInfo.workingHours?.weekDays.sort(by: { $0.order < $1.order })
        print("")
    }
}
