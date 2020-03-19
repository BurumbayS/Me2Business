//
//  AddEventTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventTableViewCell: UITableViewCell {

    var eventData: EventData!
    
    func configure(data: EventData) {
        eventData = data
    }

}
