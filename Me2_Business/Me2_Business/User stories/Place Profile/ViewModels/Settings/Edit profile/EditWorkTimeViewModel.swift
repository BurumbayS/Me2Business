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
    
    var workingHours: WorkingHours
    var editedWorkingHours: WorkingHours!
    
    init(workingHours: WorkingHours) {
        self.workingHours = workingHours
        self.editedWorkingHours = workingHours
        
        editedWorkingHours.weekDays.sort(by: { $0.order < $1.order })
    }
    
    func completeEditing() {
        self.workingHours = self.editedWorkingHours
    }
}
